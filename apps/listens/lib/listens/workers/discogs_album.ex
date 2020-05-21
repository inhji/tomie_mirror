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
  def perform(%{"action" => "fetch_cover"}, _job) do
    Albums.list_albums_without_cover(log: false)
    |> Enum.each(&fetch_album_cover/1)

    Phoenix.PubSub.broadcast(TomieWeb.PubSub, "Listens.Workers:ALL", %{event: :updated})
    Listens.Cache.try_put(@cache, :last_updated, DateTime.utc_now())

    :ok
  end

  def perform(%{"action" => "fetch_genres"}, _job) do
    Albums.list_albums_without_genres(log: false)
    |> Enum.each(&fetch_album_genres_styles/1)

    Phoenix.PubSub.broadcast(TomieWeb.PubSub, "Listens.Workers:ALL", %{event: :updated})
    Listens.Cache.try_put(@cache, :last_updated, DateTime.utc_now())

    :ok
  end

  @impl Oban.Worker
  def perform(%{"action" => "search_id"}, _job) do
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
    with decoded <- Jason.decode!(body, keys: :atoms),
         images <- Map.get(decoded, :images),
         primary_image <- Enum.find(images, fn i -> i.type == "primary" end),
         false <- is_nil(primary_image),
         image_uri <- Map.get(primary_image, :uri) do
      Logger.info("[Album/Image/Fetch] #{album.name}")

      album
      |> Album.changeset(%{image: image_uri})
      |> Repo.update(log: false)
    else
      error ->
        Logger.error(inspect(error))
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
