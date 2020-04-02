defmodule Bookmarks do
  @moduledoc """
  Documentation for `Bookmarks`.
  """
  import Ecto.Query, warn: false
  alias Bookmarks.Bookmark
  alias Db.Repo

  @doc """
  Creates a bookmark from the given attributes.

  ## Examples

    create_bookmark(%{source: "https://inhji.de"})
    iex> {:ok, %Bookmarks.Bookmark{}}

  """
  def create_bookmark(attrs \\ %{}) do
    %Bookmark{}
    |> Bookmark.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a bookmark by its id

  ## Examples

    get_bookmark(1)
    iex> {:ok, %Bookmarks.Bookmark{}}

  """
  def get_bookmark!(id), do: Repo.get!(Bookmark, id)

  @doc """
  Lists bookmarks ordered by insertion date

  ## Examples

    list_bookmarks()
    iex> [%Bookmarks.Bookmark{}]

  """
  def list_bookmarks do
    Repo.all(
      from b in Bookmark,
        select: b,
        order_by: [desc: b.inserted_at]
    )
  end

  def visit_bookmark(id) do
    bookmark = get_bookmark!(id)

    bookmark
    |> Bookmark.changeset(%{
      views: bookmark.views + 1,
      viewed_at: DateTime.utc_now()
    })
    |> Repo.update()
  end
end
