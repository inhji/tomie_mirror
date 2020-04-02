defmodule BookmarksTest do
  use ExUnit.Case
  doctest Bookmarks

  @source "https://inhji.de"

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Db.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Db.Repo, {:shared, self()})
    end

    :ok
  end

  test "create_bookmark/1 creates a new bookmark" do
    bookmark = Bookmarks.create_bookmark(%{source: @source})
    assert {:ok, %Bookmarks.Bookmark{}} = bookmark
  end

  test "get_bookmark/1 returns a bookmark by its id" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})

    assert Bookmarks.get_bookmark(bookmark.id) == bookmark
  end

  test "list_bookmarks/0 lists bookmarks ordered by insertion date" do
    {:ok, first_bookmark} = Bookmarks.create_bookmark(%{source: @source, title: "First"})
    {:ok, _second_bookmark} = Bookmarks.create_bookmark(%{source: @source, title: "Second"})

    bookmarks = Bookmarks.list_bookmarks()
    assert Enum.at(bookmarks, 0).title == first_bookmark.title
  end
end
