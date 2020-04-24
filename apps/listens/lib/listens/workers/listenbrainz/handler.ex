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
  @last_listen_timestamp "last_listen_timestamp"

  def handle_fetch_response(listens, last_ts) do
    listens
    |> prepare_listens()
    |> Enum.filter(fn l -> !is_nil(l) end)
    |> Enum.each(fn changeset ->
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
    Enum.map(listens, &prepare_listen/1)
  end

  def prepare_listen(listen) do
    %{
      additional_info: info,
      artist_name: artist_name,
      release_name: release_name,
      track_name: track_name
    } = listen.track_metadata

    with {:ok, artist} <- maybe_create_artist(artist_name, info.artist_msid),
         {:ok, album} <- maybe_create_album(release_name, info.release_msid, artist),
         {:ok, track} <- maybe_create_track(track_name, artist, album) do
      Logger.info("[Listen] #{track_name}")

      Listen.changeset(%Listen{}, %{
        track: track_name,
        album_id: album.id,
        artist_id: artist.id,
        track_id: track.id,
        listened_at: DateTime.from_unix!(listen.listened_at)
      })
    else
      {:error, reason} ->
        Logger.error(reason)
        nil

      {:warn, reason} ->
        Logger.warn(reason)
        nil
    end
  end

  def maybe_create_artist(nil, _messybrainz_id) do
    Logger.warn("Artist name was nil, skipping.")
    {:warn, "artist_name_nil"}
  end

  def maybe_create_artist(name, messybrainz_id) do
    artist =
      case Repo.get_by(Artist, [msid: messybrainz_id, name: name], log: false) do
        nil ->
          Logger.info("[Artist] #{name}")

          %Artist{}
          |> Artist.changeset(%{
            name: name,
            msid: messybrainz_id || @msid_missing
          })
          |> Repo.insert!(log: false)

        artist ->
          artist
      end

    {:ok, artist}
  end

  def maybe_create_album(nil, _messybrainz_id, _artist) do
    Logger.warn("Album name was nil, skipping.")
    {:warn, "album_name_nil"}
  end

  def maybe_create_album(name, messybrainz_id, artist) do
    album =
      case Repo.get_by(Album, [msid: messybrainz_id, artist_id: artist.id], log: false) do
        nil ->
          Logger.info("[Album] #{name}")

          %Album{}
          |> Album.changeset(%{
            name: name,
            msid: messybrainz_id || @msid_missing,
            artist_id: artist.id
          })
          |> Repo.insert!(log: false)

        album ->
          album
      end

    {:ok, album}
  end

  def maybe_create_track(name, artist, album) do
    track =
      Track
      |> Repo.get_by([name: name, artist_id: artist.id, album_id: album.id], log: false)
      |> Repo.preload([:album, :artist], log: false)

    track =
      case track do
        nil ->
          Logger.info("[Track] #{name}")

          %Track{}
          |> Track.changeset(%{
            name: name,
            artist_id: artist.id,
            album_id: album.id
          })
          |> Repo.insert!(log: false)

        track ->
          track
      end

    {:ok, track}
  end
end
