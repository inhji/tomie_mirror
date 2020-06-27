defmodule Bookmarks do
  @moduledoc """
  Documentation for `Bookmarks`.
  """
  import Ecto.Query, warn: false
  alias Bookmarks.{Bookmark}

  @preloads [:tags]
  @default_page "inbox"
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
      from [b, t] in base_query("", @default_limit),
        where: t.id == ^tag_id
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

  def list_bookmarks(search_string, page, limit \\ @default_limit) do
    search_string
    |> list_bookmarks_query(page, limit)
    |> Db.Repo.all()
  end

  defp base_query(search_string, limit) do
    query =
      from b in Bookmark,
        left_join: t in assoc(b, :tags),
        distinct: true,
        preload: ^@preloads,
        select: b,
        limit: ^limit

    case search_string do
      "" ->
        query

      search_string ->
        from [b, t] in query,
          where: ilike(b.title, ^"%#{search_string}%"),
          or_where: ilike(b.content, ^"%#{search_string}%"),
          or_where: ilike(b.source, ^"%#{search_string}%"),
          or_where: ilike(t.name, ^"%#{search_string}%"),
          or_where: ilike(t.slug, ^"%#{search_string}%")
    end
  end

  def list_bookmarks_query(search_string, page, limit) do
    base_query = base_query(search_string, limit)

    case page do
      "recent" ->
        from b in base_query,
          order_by: [desc: b.inserted_at],
          where: b.is_archived == false

      "inbox" ->
        from [b, t] in base_query,
          order_by: [desc: b.inserted_at],
          where: is_nil(t.id),
          where: b.is_archived == false

      "favorites" ->
        from b in base_query,
          where: b.is_favorite == true,
          where: b.is_archived == false,
          order_by: [desc: b.inserted_at]

      "archive" ->
        from b in base_query,
          where: b.is_archived == true,
          order_by: [desc: b.inserted_at]

      "popular" ->
        from b in base_query,
          order_by: [
            desc: b.views,
            desc: b.is_favorite,
            asc: b.is_archived
          ],
          where: b.is_archived == false

      _ ->
        list_bookmarks_query(search_string, @default_page, limit)
    end
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
