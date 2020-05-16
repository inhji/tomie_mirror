defmodule Listens.Albums do
  @moduledoc """
  The Listens.Albums context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias Listens.Albums.{Album, Uploader}

  def list_albums do
    Album
    |> order_by([:image, :name])
    |> Db.Repo.all()
    |> Db.Repo.preload(:artist)
  end

  def list_newest_albums do
    Album
    |> order_by(desc: :inserted_at)
    |> limit(6)
    |> Db.Repo.all()
    |> Db.Repo.preload([:listens, :artist])
  end

  def list_albums_without_cover(opts \\ []) do
    Album
    |> where([a], is_nil(a.image))
    |> where([a], is_nil(a.discogs_id) or a.discogs_id > 0)
    |> limit(10)
    |> Db.Repo.all(opts)
    |> Db.Repo.preload(:artist)
  end

  def get_album!(id) do
    Album
    |> Db.Repo.get!(id)
    |> Db.Repo.preload([:artist, :listens])
  end

  def get_album_image(album, size \\ :thumb) do
    Uploader.url({album.image, album}, size)
  end

  def update_album(%Album{} = album, attrs) do
    album
    |> Album.changeset(attrs)
    |> Db.Repo.update()
  end

  def merge_album(old_album_id, new_album_id) do
    old_album = get_album!(old_album_id)

    listen_query =
      from l in Listens.Listens.Listen,
        where: l.album_id == ^old_album_id

    track_query =
      from t in Listens.Tracks.Track,
        where: t.album_id == ^old_album_id

    Multi.new()
    |> Multi.update_all(:merge_listens, listen_query, set: [album_id: new_album_id])
    |> Multi.update_all(:merge_tracks, track_query, set: [album_id: new_album_id])
    |> Multi.delete(:delete_old_album, old_album)
    |> Db.Repo.transaction()
  end
end
