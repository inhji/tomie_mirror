defmodule Bookmarks do
  @moduledoc """
  Documentation for `Bookmarks`.
  """
  import Ecto.Query, warn: false
  alias Bookmarks.{Bookmark}

  @preloads [:tags]
  @default_page "recent"
  @default_limit 50

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

  def list_bookmarks_by_tag_id(tag_id) do
    Db.Repo.all(
      from [b, t] in bookmark_query(""),
        where: t.id == ^tag_id,
        select: b
    )
  end

  def count_bookmarks_by_tag_id(tag_id) do
    Db.Repo.one(
      from b in Bookmark,
        left_join: t in assoc(b, :tags),
        distinct: true,
        where: t.id == ^tag_id,
        select: count(b.id)
    )
  end

  def list_bookmarks(query, page, limit \\ @default_limit)

  def list_bookmarks(query, "recent", limit) do
    Db.Repo.all(
      from b in bookmark_query(query),
        order_by: [desc: b.inserted_at],
        where: b.is_archived == false,
        select: b,
        limit: ^limit
    )
  end

  def list_bookmarks(query, "inbox", limit) do
    Db.Repo.all(
      from [b, t] in bookmark_query(query),
        order_by: [desc: b.inserted_at],
        where: is_nil(t.id),
        where: b.is_archived == false,
        select: b
    )
  end

  def list_bookmarks(query, "favorites", limit) do
    Db.Repo.all(
      from b in bookmark_query(query),
        where: b.is_favorite == true,
        where: b.is_archived == false,
        order_by: [desc: b.inserted_at],
        select: b
    )
  end

  def list_bookmarks(query, "archive", limit) do
    Db.Repo.all(
      from b in bookmark_query(query),
        where: b.is_archived == true,
        order_by: [desc: b.inserted_at],
        select: b
    )
  end

  def list_bookmarks(query, "popular", limit) do
    Db.Repo.all(
      from b in bookmark_query(query),
        order_by: [
          desc: b.views,
          desc: b.is_favorite,
          asc: b.is_archived
        ],
        where: b.is_archived == false,
        select: b
    )
  end


  def list_bookmarks(query, _page, limit) do
    list_bookmarks(query, @default_page)
  end

  defp bookmark_query(""), do: bookmark_query()

  defp bookmark_query(query) do
    from [b, t] in bookmark_query(),
      where: ilike(b.title, ^"%#{query}%"),
      or_where: ilike(b.content, ^"%#{query}%"),
      or_where: ilike(b.source, ^"%#{query}%"),
      or_where: ilike(t.name, ^"%#{query}%"),
      or_where: ilike(t.slug, ^"%#{query}%")
  end

  defp bookmark_query() do
    from b in Bookmark,
      left_join: t in assoc(b, :tags),
      distinct: true,
      preload: ^@preloads
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

  def toggle_bookmark_flag(bookmark, flag)
      when flag in [:is_favorite, :is_published, :is_archived] do
    flag_value = Map.get(bookmark, flag, false)
    update_bookmark(bookmark, %{flag => !flag_value})
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
