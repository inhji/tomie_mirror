defmodule Listens.Albums.Album do
  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :name, :string
    field :image, Listens.Albums.Uploader.Type

    field :mbid, :string
    field :msid, :string
    field :discogs_id, :integer

    field :delete_image, :boolean,
      virtual: true,
      default: false

    belongs_to :artist, Listens.Artists.Artist
    has_many :tracks, Listens.Tracks.Track
    has_many :listens, Listens.Listens.Listen

    timestamps()
  end

  defp maybe_delete_image(changeset) do
    case get_change(changeset, :delete_image) do
      true -> put_change(changeset, :image, nil)
      _ -> changeset
    end
  end

  @doc false
  def changeset(album, attrs \\ %{}) do
    album
    |> cast(attrs, [:name, :mbid, :msid, :artist_id, :discogs_id, :delete_image])
    |> maybe_delete_image()
    |> cast_attachments(attrs, [:image], allow_paths: true)
    |> validate_required([:name, :msid, :artist_id])
  end
end
