defmodule Listens.Tracks.Track do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tracks" do
    field :name, :string

    belongs_to :album, Listens.Albums.Album
    belongs_to :artist, Listens.Artists.Artist

    has_many :listens, Listens.Listens.Listen

    timestamps()
  end

  @doc false
  def changeset(track, attrs \\ %{}) do
    track
    |> cast(attrs, [:name, :album_id, :artist_id])
    |> validate_required([:name, :album_id, :artist_id])
  end
end
