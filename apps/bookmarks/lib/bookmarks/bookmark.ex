defmodule Bookmarks.Bookmark do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field(:type, :string, default: "bookmark")

    field(:source, :string)
    field(:title, :string)
    field(:content, :string)

    timestamps()
  end

  def changeset(bookmark, attrs) do
    bookmark
    |> cast(attrs, [:source, :title, :content])
    |> validate_required([:source])
  end
end
