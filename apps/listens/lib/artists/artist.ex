defmodule Listens.Artists.Artist do
  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field :name, :string
    field :image, Listens.Artists.Uploader.Type

    field :msid, :string
    field :mbid, :string
    field :discogs_id, :integer

    field :delete_image, :boolean,
      virtual: true,
      default: false

    has_many :albums, Listens.Albums.Album
    has_many :tracks, Listens.Tracks.Track
    has_many :listens, Listens.Listens.Listen

    timestamps()
  end

  @doc false
  def changeset(artist \\ %__MODULE__{}, attrs \\ %{}) do
    artist
    |> cast(attrs, [:name, :msid, :mbid, :discogs_id])
    |> cast_attachments(attrs, [:image], allow_paths: true)
    |> validate_required([:name, :msid])
  end
end
