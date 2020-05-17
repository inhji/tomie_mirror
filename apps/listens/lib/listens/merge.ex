defmodule Listens.Merge do
  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias Listens.Listens.Listen
  alias Listens.Tracks.Track

  def merge_album(old_album_id, new_album_id) do
    old_album = Listens.Albums.get_album!(old_album_id)

    track_query =
      from t in Track,
        where: t.album_id == ^old_album_id or t.album_id == ^new_album_id,
        select: fragment("UPPER(?)", t.name),
        distinct: true

    upcase_tracks = Db.Repo.all(track_query)

    Multi.new()
    |> prepare_merge(upcase_tracks, old_album_id, new_album_id)
    |> Multi.delete(:delete_old_album, old_album)
    |> IO.inspect()

    # |> Db.Repo.transaction()
  end

  def prepare_merge(multi, track_names, old_album_id, new_album_id) do
    Enum.reduce(track_names, multi, fn track_name, inner_multi ->
      merge_track(inner_multi, track_name, old_album_id, new_album_id)
    end)
  end

  def merge_track(multi, name, old_album_id, new_album_id) do
    upcased_name = ~r/\s/ |> Regex.replace(String.upcase(name), "")

    base_query =
      from t in Listens.Tracks.Track,
        where: fragment("UPPER(?) = ?", t.name, ^name)

    old_query = from t in base_query, where: t.album_id == ^old_album_id, select: t.id
    new_query = from t in base_query, where: t.album_id == ^new_album_id, select: t.id

    case {Db.Repo.all(old_query), Db.Repo.all(new_query)} do
      {[], _new} ->
        # Do nothing, no tracks/listens to be merged
        multi

      {old, []} ->
        # Update old track to point to new album
        # Update Listens to point to new album
        # DO NOT DELETE OLD TRACK
        track_query =
          from t in Track,
            where: t.id in ^old

        listen_query =
          from l in Listen,
            where: l.track_id in ^old

        multi
        |> Multi.update_all("merge_track_#{upcased_name}", track_query,
          set: [album_id: new_album_id]
        )
        |> Multi.update_all("merge_listens_#{upcased_name}", listen_query,
          set: [album_id: new_album_id]
        )

      {old, new} ->
        # Merge listens to new track
        # Delete old track
        listen_query =
          from l in Listen,
            where: l.track_id in ^old

        deletion_query =
          from t in Track,
            where: t.id in ^old

        multi
        |> Multi.update_all("merge_listens_#{upcased_name}", listen_query,
          set: [
            track_id: List.first(new),
            album_id: new_album_id
          ]
        )
        |> Multi.delete_all("delete_old_track_#{upcased_name}", deletion_query)
    end
  end
end
