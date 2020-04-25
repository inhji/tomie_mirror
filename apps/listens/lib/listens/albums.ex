defmodule Listens.Albums do
  @moduledoc """
  The Listens.Albums context.
  """

  import Ecto.Query, warn: false
  alias Listens.Albums.Album

  def list_albums do
    Album
    |> order_by([:image, :name])
    |> Db.Repo.all()
    |> Db.Repo.preload(:artist)
  end

  def list_albums_without_cover(opts \\ []) do
    Album
    |> where([a], is_nil(a.image))
    |> where([a], is_nil(a.discogs_id) or a.discogs_id > 0)
    |> limit(10)
    |> Db.Repo.all(opts)
    |> Db.Repo.preload(:artist)
  end

  def get_album!(id),
    do:
      Db.Repo.get!(Album, id)
      |> Db.Repo.preload([:artist, :listens])

  def update_album(%Album{} = album, attrs) do
    album
    |> Album.changeset(attrs)
    |> Db.Repo.update()
  end
end
