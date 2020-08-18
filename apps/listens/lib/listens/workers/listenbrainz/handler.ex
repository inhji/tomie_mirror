defmodule Listens.Workers.Listenbrainz.Handler do
  import Ecto.Query
  require Logger

  alias Db.Repo
  alias Listens.Artists.Artist
  alias Listens.Albums.Album
  alias Listens.Tracks.Track
  alias Listens.Listens.Listen

  @msid_missing "MISSING"
  @cache :listenbrainz
  @last_listen_timestamp :last_listen_timestamp

  def handle_fetch_response(listens, last_ts) do
    %{
      changesets: changesets,
      new_artists: _new_artists,
      new_albums: _new_albums,
      new_tracks: _new_tracks
    } = prepare_listens(listens)

    Enum.each(changesets, fn changeset ->
      Repo.insert(changeset, log: false)
    end)

    case Enum.empty?(listens) do
      true ->
        last_ts

      false ->
        listens
        |> List.last()
        |> Map.get(:listened_at)
    end
  end

  def last_listen_timestamp() do
    case Cachex.exists?(@cache, @last_listen_timestamp) do
      {:ok, true} ->
        Cachex.get!(@cache, @last_listen_timestamp)

      _ ->
        query =
          from l in Listen,
            order_by: [desc: l.listened_at],
            limit: 1

        ts =
          case Repo.one(query, log: false) do
            nil -> 1
            listen -> DateTime.to_unix(listen.listened_at)
          end

        Cachex.put(@cache, @last_listen_timestamp, ts)

        ts
    end
  end

  def prepare_listens(listens) do
    initial_state = %{
      changesets: [],
      new_artists: 0,
      new_albums: 0,
      new_tracks: 0
    }

    Enum.reduce(listens, initial_state, &prepare_listen/2)
  end

  def prepare_listen(listen, state) do
    %{
      additional_info: info,
      artist_name: artist_name,
      release_name: release_name,
      track_name: track_name
    } = get_track_metadata(listen)

    with {:ok, artist, new: new_artist} <- maybe_create_artist(artist_name, info.artist_msid),
         {:ok, album, new: new_album} <-
           maybe_create_album(release_name, info.release_msid, artist),
         {:ok, track, new: new_track} <- maybe_create_track(track_name, artist, album) do
      changeset =
        Listen.changeset(%Listen{}, %{
          track: track_name,
          album_id: album.id,
          artist_id: artist.id,
          track_id: track.id,
          listened_at: DateTime.from_unix!(listen.listened_at)
        })

      state
      |> Map.put(:changesets, state.changesets ++ [changeset])
      |> Map.put(:new_artists, state.new_artists + bool_to_int(new_artist))
      |> Map.put(:new_albums, state.new_albums + bool_to_int(new_album))
      |> Map.put(:new_tracks, state.new_tracks + bool_to_int(new_track))
    else
      {:error, reason} ->
        Logger.error(reason)
        state

      {:warn, reason} ->
        Logger.warn(reason)
        state
    end
  end

  def get_track_metadata(listen) do
    %{
      additional_info: Map.get(listen.track_metadata, :additional_info, nil),
      artist_name: Map.get(listen.artist_name, :artist_name, nil),
      release_name: Map.get(listen.release_name, :release_name, nil),
      track_name: Map.get(listen.track_name, :track_name, nil)
    }
  end

  def bool_to_int(true), do: 1
  def bool_to_int(false), do: 0

  def maybe_create_artist(nil, _messybrainz_id) do
    {:warn, "Artist name was nil, skipping."}
  end

  def maybe_create_artist(name, messybrainz_id) do
    case Repo.get_by(Artist, [msid: messybrainz_id, name: name], log: false) do
      nil ->
        Logger.debug("[Artist] #{name}")

        artist =
          %Artist{}
          |> Artist.changeset(%{
            name: name,
            msid: messybrainz_id || @msid_missing
          })
          |> Repo.insert!(log: false)

        {:ok, artist, new: true}

      artist ->
        {:ok, artist, new: false}
    end
  end

  def maybe_create_album(nil, _messybrainz_id, _artist) do
    {:warn, "Album name was nil, skipping."}
  end

  def maybe_create_album(_album_name, nil, _artist) do
    {:warn, "Album MSID was nil, skipping."}
  end

  def maybe_create_album(name, messybrainz_id, artist) do
    case Repo.get_by(Album, [msid: messybrainz_id, artist_id: artist.id], log: false) do
      nil ->
        Logger.debug("[Album] #{name}")

        album =
          %Album{}
          |> Album.changeset(%{
            name: name,
            msid: messybrainz_id || @msid_missing,
            artist_id: artist.id
          })
          |> Repo.insert!(log: false)

        {:ok, album, new: true}

      album ->
        {:ok, album, new: false}
    end
  end

  def maybe_create_track(name, artist, album) do
    query =
      from t in Track,
        where: t.name == ^name,
        where: t.artist_id == ^artist.id,
        where: t.album_id == ^album.id

    track_list =
      query
      |> Repo.all(log: false)
      |> Repo.preload([:album, :artist], log: false)

    case track_list do
      [] ->
        Logger.debug("[Track] #{name}")

        track =
          %Track{}
          |> Track.changeset(%{
            name: name,
            artist_id: artist.id,
            album_id: album.id
          })
          |> Repo.insert!(log: false)

        {:ok, track, new: true}

      [track | _rest] ->
        {:ok, track, new: false}
    end
  end
end
