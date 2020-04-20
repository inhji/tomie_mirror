defmodule BookmarksTest do
  use ExUnit.Case
  doctest Bookmarks
  alias Bookmarks.Bookmark

  @source "https://inhji.de"
  @title "some title"
  @post_type "bookmark"

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Db.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Db.Repo, {:shared, self()})
    end

    :ok
  end

  def has_tags?(bookmark, tags) do
    existing =
      bookmark.tags
      |> Enum.map(&Map.get(&1, :name))
      |> Enum.sort()

    existing == Enum.sort(tags)
  end

  test "create_bookmark/1 creates a new bookmark and has required fields" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    assert %Bookmark{} = bookmark
    assert bookmark.source == @source
    assert bookmark.type == @post_type
  end

  test "update_bookmark/2 updates a bookmarks with the given attributes" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    {:ok, updated_bookmark} = Bookmarks.update_bookmark(bookmark, %{title: @title})
    assert bookmark.title != updated_bookmark.title
    assert updated_bookmark.title == @title
  end

  test "get_bookmark/1 returns a bookmark by its id" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    new_bookmark = Bookmarks.get_bookmark!(bookmark.id)

    assert new_bookmark.id == bookmark.id
    assert new_bookmark.source == bookmark.source
  end

  test "list_bookmarks/0 lists bookmarks" do
    {:ok, _first_bookmark} = Bookmarks.create_bookmark(%{source: @source, title: "First"})
    {:ok, _second_bookmark} = Bookmarks.create_bookmark(%{source: @source, title: "Second"})

    assert [%Bookmark{}, %Bookmark{}] = Bookmarks.list_bookmarks()
  end

  test "list_bookmarks/2 with page inbox lists bookmarks without views or without tags" do
    {:ok, first_bookmark} = Bookmarks.create_bookmark(%{source: @source, title: "First"})
    {:ok, _second_bookmark} = Bookmarks.create_bookmark(%{source: @source, title: "Second"})

    assert [%Bookmark{}, %Bookmark{}] = Bookmarks.list_bookmarks("", "inbox")

    Bookmarks.update_tags(["foo"], first_bookmark)
    Bookmarks.visit_bookmark(first_bookmark)

    assert [%Bookmark{}] = Bookmarks.list_bookmarks("", "inbox")
  end

  test "list_bookmarks/2 with page popular orders bookmarks by views, favorites and archive status" do
    {:ok, first_bookmark} = Bookmarks.create_bookmark(%{source: @source, title: "First"})
    {:ok, second_bookmark} = Bookmarks.create_bookmark(%{source: @source, title: "Second"})

    assert [%Bookmark{}, %Bookmark{}] = Bookmarks.list_bookmarks("", "popular")

    Bookmarks.visit_bookmark(first_bookmark)
    Bookmarks.toggle_bookmark_flag(first_bookmark, :is_favorite)
    Bookmarks.toggle_bookmark_flag(second_bookmark, :is_archived)

    bookmarks = Bookmarks.list_bookmarks("", "popular")
    assert [%Bookmark{title: "First"}] = bookmarks
    assert Enum.at(bookmarks, 0).views === 1
    assert Enum.at(bookmarks, 0).is_favorite === true
  end

  test "list_bookmarks/2 with page favorites lists favorited bookmarks" do
    {:ok, first_bookmark} = Bookmarks.create_bookmark(%{source: @source, title: "First"})

    assert [] = Bookmarks.list_bookmarks("", "favorites")

    Bookmarks.toggle_bookmark_flag(first_bookmark, :is_favorite)

    assert [%Bookmark{}] = Bookmarks.list_bookmarks("", "favorites")
  end

  test "visit_bookmark/1 increments visits and updates visited_at" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    {:ok, viewed_bookmark} = Bookmarks.visit_bookmark(bookmark)
    {:ok, viewed_bookmark} = Bookmarks.visit_bookmark(viewed_bookmark)
    {:ok, viewed_bookmark} = Bookmarks.visit_bookmark(viewed_bookmark)

    assert viewed_bookmark.views == bookmark.views + 3
    assert viewed_bookmark.viewed_at != bookmark.viewed_at
  end

  test "update_tags/2 merges the existing tags with the supplied tags for a given bookmark" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})

    {:ok, updated_bookmark} = Bookmarks.update_tags(["foo"], bookmark)
    assert Enum.count(updated_bookmark.tags) == 1
    assert has_tags?(updated_bookmark, ["foo"])

    {:ok, updated_bookmark} = Bookmarks.update_tags("foo, bar", bookmark)
    assert Enum.count(updated_bookmark.tags) == 2
    assert has_tags?(updated_bookmark, ["foo", "bar"])

    {:ok, updated_bookmark} = Bookmarks.update_tags(["foo"], bookmark)
    assert Enum.count(updated_bookmark.tags) == 2
    assert has_tags?(updated_bookmark, ["foo", "bar"])

    {:ok, updated_bookmark} = Bookmarks.update_tags("foo, foo", bookmark)
    assert Enum.count(updated_bookmark.tags) == 2
    assert has_tags?(updated_bookmark, ["foo", "bar"])
  end

  test "set_tags/2 sets new tags for the given bookmark" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})

    {:ok, updated_bookmark} = Bookmarks.set_tags("foo", bookmark)
    assert Enum.count(updated_bookmark.tags) == 1
    assert has_tags?(updated_bookmark, ["foo"])

    {:ok, updated_bookmark} = Bookmarks.set_tags("bar", bookmark)
    assert Enum.count(updated_bookmark.tags) == 1
    assert has_tags?(updated_bookmark, ["bar"])
  end

  test "delete_bookmark/1 deletes a bookmark" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    Bookmarks.update_tags(["foo", "bar"], bookmark)
    Bookmarks.delete_bookmark(bookmark)

    assert_raise Ecto.NoResultsError, fn ->
      Bookmarks.get_bookmark!(bookmark.id)
    end
  end

  test "toggle_bookmark_flag/2 toggles a flag on the bookmark" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    {:ok, updated_bookmark} = Bookmarks.toggle_bookmark_flag(bookmark, :is_archived)

    assert updated_bookmark.is_archived === true
  end
end
