defmodule Bookmarks do
  @moduledoc """
  Documentation for `Bookmarks`.
  """
  import Ecto.Query, warn: false
  alias Bookmarks.{Bookmark}

  @doc """
  Creates a bookmark from the given attributes.

  ## Examples

    create_bookmark(%{source: "https://inhji.de"})
    iex> {:ok, %Bookmarks.Bookmark{}}

  """
  def create_bookmark(attrs \\ %{}) do
    %Bookmark{}
    |> Bookmark.changeset(attrs)
    |> Db.Repo.insert()
  end

  @doc """
  Updates a bookmark's tags

  ## Examples

    update_tags(["foo", "bar"], 1)
    iex> {:ok, %Bookmarks.Bookmark{}}

  """
  def update_tags(tags, bookmark_id) when is_list(tags) do
    bookmark = Bookmarks.get_bookmark!(bookmark_id)

    tags
    |> Tags.update_tags_for_entity(bookmark)
  end

  @doc """
  Updates a bookmarks tags

  ## Examples

  update_tags("foo, bar", 1)
  iex> {:ok, %Bookmarks.Bookmark{}}

  """
  def update_tags(tags, bookmark_id) when is_binary(tags) do
    bookmark = Bookmarks.get_bookmark!(bookmark_id)

    tags
    |> Tags.from_string()
    |> Tags.update_tags_for_entity(bookmark)
  end

  @doc """
  Gets a bookmark by its id

  ## Examples

    get_bookmark(1)
    iex> {:ok, %Bookmarks.Bookmark{}}

  """
  def get_bookmark!(id), do: Db.Repo.get!(Bookmark, id) |> Db.Repo.preload([:tags])

  @doc """
  Lists bookmarks ordered by insertion date

  ## Examples

    list_bookmarks()
    iex> [%Bookmarks.Bookmark{}]

  """
  def list_bookmarks do
    Db.Repo.all(
      from b in Bookmark,
        select: b,
        order_by: [desc: b.inserted_at],
        preload: [:tags]
    )
  end

  @doc """
  Registers a visit of the bookmarks url by updating `views` and `viewed_at`

  ## Examples

    visit_bookmark(1)
    iex> {:ok, %Bookmarks.Bookmark{}}

  """
  def visit_bookmark(id) do
    bookmark = get_bookmark!(id)

    bookmark
    |> Bookmark.changeset(%{
      views: bookmark.views + 1,
      viewed_at: DateTime.utc_now()
    })
    |> Db.Repo.update()
  end
end
