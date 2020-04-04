defmodule Bookmarks.BookmarkTag do
  use Ecto.Schema
  use Bookmarks.Constants
  import Ecto.Changeset

  schema "posts_tags" do
    belongs_to :bookmark, Bookmarks.Bookmark, foreign_key: :post_id
    belongs_to :tag, Tags.Tag
  end

  @doc false
  def changeset(bookmark_tag, attrs) do
    bookmark_tag
    |> cast(attrs, [:post_id, :tag_id])
    |> unique_constraint(:tag_id, name: :posts_tags_post_id_tag_id_index)
  end
end
