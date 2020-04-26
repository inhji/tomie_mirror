defmodule Listens.Artists do
  import Ecto.Query, warn: false

  alias Listens.Artists.{Artist, Uploader}

  def list_artists_without_image(opts \\ []) do
    Artist
    |> where([a], is_nil(a.image))
    |> where([a], is_nil(a.discogs_id) or a.discogs_id > 0)
    |> limit(10)
    |> Db.Repo.all(opts)
  end

  def get_artist!(id) do
    Db.Repo.get!(Artist, id)
    |> Db.Repo.preload([:listens, :tracks, albums: [:listens]])
  end

  def get_artist_image(artist, size \\ :thumb) do
    Uploader.url({artist.image, artist}, size)
  end
end
