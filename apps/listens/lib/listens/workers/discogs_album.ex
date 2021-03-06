defmodule Listens.Workers.DiscogsAlbum do
  use Oban.Worker,
    queue: :listens,
    max_attempts: 3,
    unique: [period: 60, fields: [:worker, :args]]

  require Logger

  alias Db.Repo
  alias Listens.Albums
  alias Listens.Albums.Album

  @cache :discogs
  @base_url "https://api.discogs.com"
  @token Application.compile_env(:listens, :discogs_token)
  @invalid_discogs_id -1
  @rate_limit :rate_limit

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"action" => "fetch_cover"}}) do
    Albums.list_albums_without_cover(log: false)
    |> Enum.each(&fetch_album_cover/1)

    Phoenix.PubSub.broadcast(TomieWeb.PubSub, "Listens.Workers:ALL", %{event: :updated})
    Listens.Cache.try_put(@cache, :last_updated, DateTime.utc_now())

    :ok
  end

  def perform(%Oban.Job{args: %{"action" => "fetch_genres"}}) do
    Albums.list_albums_without_genres(log: false)
    |> Enum.each(&fetch_album_genres_styles/1)

    Phoenix.PubSub.broadcast(TomieWeb.PubSub, "Listens.Workers:ALL", %{event: :updated})
    Listens.Cache.try_put(@cache, :last_updated, DateTime.utc_now())

    :ok
  end

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"action" => "search_id"}}) do
    Albums.list_albums_without_discogs_id(log: false)
    |> Enum.each(&search_discogs_id/1)

    Phoenix.PubSub.broadcast(TomieWeb.PubSub, "Listens.Workers:ALL", %{event: :updated})
    Listens.Cache.try_put(@cache, :last_updated, DateTime.utc_now())

    :ok
  end

  def fetch_album_genres_styles(album) do
    url = get_fetch_url(album)

    Logger.info("[Album/Genres/Fetch] #{album.name}")
    Logger.info("[Album/Genres/Fetch] #{url}")

    case Http.get!(url) do
      %HTTPoison.Response{body: body, headers: headers} ->
        handle_genres_fetch_response(body, album)
        rate_limit = Listens.RateLimit.calculate(headers, :discogs)

        Listens.Cache.try_put(@cache, @rate_limit, rate_limit)

      error ->
        Logger.error(inspect(error))
    end
  end

  def handle_genres_fetch_response(body, album) do
    decoded = Jason.decode!(body, keys: :atoms)

    genres = Map.get(decoded, :genres)
    styles = Map.get(decoded, :styles)

    Logger.info("[Album/Genres/Fetch] Genres: #{inspect(genres)}")
    Logger.info("[Album/Genres/Fetch] Styles: #{inspect(styles)}")

    genres = if is_nil(genres), do: [], else: genres
    styles = if is_nil(styles), do: [], else: styles

    album
    |> Album.changeset(%{genres: genres, styles: styles})
    |> Repo.update(log: false)
  end

  def fetch_album_cover(album) do
    url = get_fetch_url(album)

    Logger.info("[Album/Image/Fetch] #{url}")

    case Http.get!(url) do
      %HTTPoison.Response{body: body, headers: headers} ->
        handle_cover_fetch_response(body, album)
        rate_limit = Listens.RateLimit.calculate(headers, :discogs)
        Listens.Cache.try_put(@cache, @rate_limit, rate_limit)

      error ->
        Logger.error(inspect(error))
    end
  end

  def handle_cover_fetch_response(body, album) do
    case Jason.decode(body, keys: :atoms) do
      {:ok, json} ->
        case maybe_get_image(json) do
          nil ->
            Logger.warn("[Album/Image/Fetch] No cover image found for #{album.name}")

          cover_image ->
            image_uri = Map.get(cover_image, :uri)

            album
            |> Album.changeset(%{image: image_uri})
            |> Repo.update(log: false)
        end

      {:error, error} ->
        Logger.error("[Album/Image/Fetch] #{inspect(error)}")
    end
  end

  def maybe_get_image(json) do
    case Map.get(json, :images) do
      nil -> nil
      images -> Enum.find(images, fn i -> i.type in ["primary", "secondary"] end)
    end
  end

  def search_discogs_id(album) do
    url = get_search_url(album)

    Logger.info("[Album/DiscogsId/Search] #{url}")

    case Http.get!(url) do
      %HTTPoison.Response{body: body, headers: headers} ->
        handle_search_response(body, album)
        rate_limit = Listens.RateLimit.calculate(headers, :discogs)
        Listens.Cache.try_put(@cache, @rate_limit, rate_limit)

      error ->
        Logger.error(inspect(error))
    end
  end

  def handle_search_response(body, album) do
    with decoded <- Jason.decode!(body, keys: :atoms),
         results <- Map.get(decoded, :results),
         false <- is_nil(results),
         data <- List.first(results),
         false <- is_nil(data),
         discogs_id = data.id do
      Logger.info("[Album/DiscogsId/Search] #{album.name}")

      album
      |> Album.changeset(%{discogs_id: discogs_id})
      |> Repo.update(log: false)
    else
      _error ->
        Logger.debug("[Album/DiscogsId/Search] No id found for #{album.name}")

        album
        |> Album.changeset(%{discogs_id: @invalid_discogs_id})
        |> Repo.update(log: false)
    end
  end

  def get_search_url(album) do
    album_name = URI.encode(album.name)
    artist_name = URI.encode(album.artist.name)

    "#{@base_url}/database/search?token=#{@token}&release_title=#{album_name}&artist=#{
      artist_name
    }"
  end

  def get_fetch_url(%{discogs_id: discogs_id}) do
    "#{@base_url}/releases/#{discogs_id}?token=#{@token}"
  end
end
