defmodule Bookmarks do
  @moduledoc """
  Documentation for `Bookmarks`.
  """
  import Ecto.Query, warn: false
  alias Bookmarks.{Bookmark}

  @preloads [:tags]

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
    |> Db.Repo.preload(@preloads)
    |> Bookmark.changeset(attrs)
    |> Db.Repo.update()
  end

  @doc """
  Gets a bookmark by its id
  """
  def get_bookmark!(id),
    do:
      Db.Repo.get!(Bookmark, id)
      |> Db.Repo.preload(@preloads)

  @doc """
  Lists bookmarks ordered by insertion date
  """
  def list_bookmarks(limit \\ 999) do
    Db.Repo.all(
      from b in Bookmark,
        select: b,
        order_by: [desc: b.inserted_at],
        preload: ^@preloads,
        limit: ^limit
    )
  end

  def list_bookmarks_by_tag(tag) do
    Db.Repo.all(
      from b in Bookmarks.Bookmark,
        join: t in assoc(b, :tags),
        select: b,
        where: t.name == ^tag,
        or_where: t.slug == ^tag,
        preload: ^@preloads
    )
  end

  def query_bookmarks(search_string) do
    Db.Repo.all(
      from b in Bookmark,
        join: t in assoc(b, :tags),
        select: b,
        order_by: [desc: b.inserted_at],
        where: ilike(b.title, ^"%#{search_string}%"),
        or_where: ilike(b.content, ^"%#{search_string}%"),
        or_where: ilike(b.source, ^"%#{search_string}%"),
        or_where: t.name == ^search_string,
        or_where: t.slug == ^search_string,
        preload: ^@preloads,
        limit: 10
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
  Updates a bookmarks tags.

  Bookmark is reloaded to ensure it's tags are loaded
  """
  def update_tags(tags, bookmark) when is_binary(tags) do
    bookmark = Bookmarks.get_bookmark!(bookmark.id)

    tags
    |> Tags.from_string()
    |> update_tags(bookmark)
  end

  @doc """
  Updates a bookmark's tags

  Bookmark is reloaded to ensure it's tags are loaded
  """
  def update_tags(tags, bookmark) when is_list(tags) do
    bookmark = Bookmarks.get_bookmark!(bookmark.id)

    bookmark.tags
    |> Enum.map(&Map.get(&1, :name))
    |> Enum.concat(tags)
    |> Tags.update_tags_for_entity(bookmark)
  end

  @doc """
  Sets a bookmark tags overwriting existing tags
  """
  def set_tags(tags, bookmark) when is_binary(tags) do
    bookmark = Bookmarks.get_bookmark!(bookmark.id)

    tags
    |> Tags.from_string()
    |> Tags.update_tags_for_entity(bookmark)
  end
end
