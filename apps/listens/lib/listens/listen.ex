defmodule Listens.Listens.Listen do
  use Ecto.Schema
  import Ecto.Changeset

  schema "listens" do
    field :listened_at, :utc_datetime

    belongs_to :track, Listens.Tracks.Track
    belongs_to :artist, Listens.Artists.Artist
    belongs_to :album, Listens.Albums.Album

    timestamps()
  end

  @doc false
  def changeset(listen, attrs \\ %{}) do
    listen
    |> cast(attrs, [:track_id, :album_id, :artist_id, :listened_at])
    |> validate_required([:track_id, :album_id, :artist_id, :listened_at])
  end
end
