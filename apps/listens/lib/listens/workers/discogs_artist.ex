defmodule Listens.Workers.DiscogsArtist do
  use Oban.Worker,
    queue: :listens,
    max_attempts: 3

  require Logger

  alias Db.Repo
  alias Listens.Artists
  alias Listens.Artists.Artist

  @base_url "https://api.discogs.com/database/search"
  @cache :discogs_artist

  @token Application.compile_env(:listens, :discogs_token)
  @invalid_discogs_id -1
  @rate_limit "rate_limit"

  @impl Oban.Worker
  def perform(_args, _job) do
    Artists.list_artists_without_image(log: false)
    |> Enum.each(&fetch_artist_image/1)

    Listens.Cache.try_put(@cache, "updated_at", DateTime.utc_now())

    :ok
  end

  def fetch_artist_image(artist) do
    url = get_url(artist)

    case HTTPoison.get!(url) do
      %HTTPoison.Response{body: body, headers: headers} ->
        handle_fetch_response(body, artist)
        rate_limit = Listens.RateLimit.calculate(headers, :discogs)
        Listens.Cache.try_put(@cache, @rate_limit, rate_limit)

      error ->
        Logger.error(inspect(error))
    end
  end

  def handle_fetch_response(body, artist) do
    with decoded <- Jason.decode!(body, keys: :atoms),
         results <- Map.get(decoded, :results),
         false <- is_nil(results),
         data <- List.first(results),
         false <- is_nil(data),
         false <- String.ends_with?(data.cover_image, "spacer.gif") do
      discogs_id = data.id
      image = data.cover_image

      Logger.info("[Artist/Image] #{artist.name}")

      artist
      |> Artist.changeset(%{
        image: image,
        discogs_id: discogs_id
      })
      |> Repo.update(log: false)
    else
      _error ->
        Logger.debug("[Artist/Image] No image found for #{artist.name}")

        artist
        |> Artist.changeset(%{discogs_id: @invalid_discogs_id})
        |> Repo.update(log: false)
    end
  end

  def get_url(artist) do
    artist_name = URI.encode(artist.name)

    "#{@base_url}?token=#{@token}&type=artist&type=artist&query=#{artist_name}"
  end
end
