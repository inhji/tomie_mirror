defmodule Listens.Workers.DiscogsAlbum do
  use Oban.Worker,
    queue: :listens,
    max_attempts: 3,
    unique: [period: 60, fields: [:worker]]

  require Logger

  alias Db.Repo
  alias Listens.Albums
  alias Listens.Albums.Album

  @cache :discogs_album
  @base_url "https://api.discogs.com/database/search"
  @token Application.compile_env(:listens, :discogs_token)
  @invalid_discogs_id -1
  @rate_limit "rate_limit"

  @impl Oban.Worker
  def perform(_args, _job) do
    albums = Albums.list_albums_without_cover(log: false)
    Enum.each(albums, &fetch_album_cover/1)

    Listens.Cache.try_put(@cache, "updated_at", DateTime.utc_now())

    Phoenix.PubSub.broadcast(TomieWeb.PubSub, "Listens.Workers:ALL", %{
      event: :updated
    })

    :ok
  end

  def fetch_album_cover(album) do
    url = get_url(album)

    case HTTPoison.get!(url) do
      %HTTPoison.Response{body: body, headers: headers} ->
        handle_fetch_response(body, album)
        rate_limit = Listens.RateLimit.calculate(headers, :discogs)
        Listens.Cache.try_put(@cache, @rate_limit, rate_limit)

      error ->
        Logger.error(inspect(error))
    end
  end

  def handle_fetch_response(body, album) do
    with decoded <- Jason.decode!(body, keys: :atoms),
         results <- Map.get(decoded, :results),
         false <- is_nil(results),
         data <- List.first(results),
         false <- is_nil(data),
         false <- String.ends_with?(data.cover_image, "spacer.gif") do
      discogs_id = data.id
      image = data.cover_image

      Logger.info("[Album/Image] #{album.name}")

      album
      |> Album.changeset(%{
        image: image,
        discogs_id: discogs_id
      })
      |> Repo.update(log: false)
    else
      _error ->
        Logger.debug("[Album/Image] No image found for #{album.name}")

        album
        |> Album.changeset(%{
          discogs_id: @invalid_discogs_id
        })
        |> Repo.update(log: false)
    end
  end

  def get_url(album) do
    album_name = URI.encode(album.name)
    artist_name = URI.encode(album.artist.name)

    "#{@base_url}?token=#{@token}&release_title=#{album_name}&artist=#{artist_name}"
  end
end
