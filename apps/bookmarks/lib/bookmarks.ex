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
    query =
      from(b in Bookmark,
        select: b,
        order_by: [desc: b.inserted_at]
      )

    Repo.all(query)
  end
end
