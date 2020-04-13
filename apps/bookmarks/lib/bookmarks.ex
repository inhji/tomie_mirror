defmodule Bookmarks do
  @moduledoc """
  Documentation for `Bookmarks`.
  """
  import Ecto.Query, warn: false
  alias Bookmarks.{Bookmark}

  @doc """
  Creates a bookmark from the given attributes.

  """
  def create_bookmark(attrs \\ %{}) do
    %Bookmark{}
    |> Bookmark.changeset(attrs)
    |> Db.Repo.insert()
  end

  @doc """
  Updates a bookmarks with the given attributes
  """
  def update_bookmark(bookmark, attrs) do
    bookmark
    |> Db.Repo.preload(:tags)
    |> Bookmark.changeset(attrs)
    |> Db.Repo.update()
  end

  @doc """
  Gets a bookmark by its id
  """
  def get_bookmark!(id),
    do:
      Db.Repo.get!(Bookmark, id)
      |> Db.Repo.preload([:tags])

  @doc """
  Lists bookmarks ordered by insertion date
  """
  def list_bookmarks do
    Db.Repo.all(
      from b in Bookmark,
        select: b,
        order_by: [desc: b.inserted_at],
        preload: [:tags]
    )
  end

  def query_bookmarks(search_string) do
    Db.Repo.all(
      from b in Bookmark,
        select: b,
        where: ilike(b.title, ^"%#{search_string}%"),
        preload: [:tags]
    )
  end

  @doc """
  Registers a visit of the bookmarks url by updating `views` and `viewed_at`
  """
  def visit_bookmark(bookmark) do
    bookmark
    |> Db.Repo.preload(:tags)
    |> Bookmark.changeset(%{
      views: bookmark.views + 1,
      viewed_at: DateTime.utc_now()
    })
    |> Db.Repo.update()
  end

  def delete_bookmark(bookmark) do
    Db.Repo.delete(bookmark)
  end

  @doc """
  Updates a bookmark's tags

  Bookmark is reloaded to ensure it's tags are loaded
  """
  def update_tags(tags, bookmark) when is_list(tags) do
    bookmark = Bookmarks.get_bookmark!(bookmark.id)

    tags
    |> Tags.update_tags_for_entity(bookmark)
  end

  @doc """
  Updates a bookmarks tags.

  Bookmark is reloaded to ensure it's tags are loaded
  """
  def update_tags(tags, bookmark) when is_binary(tags) do
    bookmark = Bookmarks.get_bookmark!(bookmark.id)

    tags
    |> Tags.from_string()
    |> Tags.update_tags_for_entity(bookmark)
  end
end
