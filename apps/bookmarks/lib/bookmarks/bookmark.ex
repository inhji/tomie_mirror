defmodule Bookmarks.Bookmark do
  use Ecto.Schema
  use Bookmarks.Constants
  import Ecto.Changeset

  defimpl String.Chars do
    def to_string(%{source: source}) do
      "Bookmark<#{source}>"
    end
  end

  schema "posts" do
    field(:type, :string, default: @post_type)

    field(:source, :string)
    field(:title, :string)
    field(:content, :string)

    field(:views, :integer, default: 0)
    field(:viewed_at, :naive_datetime)

    many_to_many :tags, Tags.Tag,
      join_through: "posts_tags",
      join_keys: [post_id: :id, tag_id: :id],
      on_replace: :delete,
      unique: true

    timestamps()
  end

  def changeset(bookmark, attrs \\ %{}) do
    bookmark
    |> cast(attrs, [:source, :title, :content, :views, :viewed_at])
    |> validate_required([:source, :type])
  end
end
