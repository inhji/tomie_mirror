defmodule Bookmarks.Bookmark do
  use Ecto.Schema
  use Bookmarks.Constants
  import Ecto.Changeset

  schema "posts" do
    field(:type, :string, default: @post_type)

    field(:source, :string)
    field(:title, :string)
    field(:content, :string)

    timestamps()
  end

  def changeset(bookmark, attrs \\ %{}) do
    bookmark
    |> cast(attrs, [:source, :title, :content])
    |> validate_required([:source, :type])
  end
end
