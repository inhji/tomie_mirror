defmodule BookmarksTest do
  use ExUnit.Case
  doctest Bookmarks

  @source "https://inhji.de"
  @post_type "bookmark"
  @tag_name "some tag"

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Db.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Db.Repo, {:shared, self()})
    end

    :ok
  end

  test "create_bookmark/1 creates a new bookmark and has required fields" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    assert %Bookmarks.Bookmark{} = bookmark
    assert bookmark.source == @source
    assert bookmark.type == @post_type
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

    assert [%Bookmarks.Bookmark{}, %Bookmarks.Bookmark{}] = Bookmarks.list_bookmarks()
  end

  test "visit_bookmark/1 increments visits and updates visited_at" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    {:ok, viewed_bookmark} = Bookmarks.visit_bookmark(bookmark.id)

    assert viewed_bookmark.views == bookmark.views + 1
    assert viewed_bookmark.viewed_at != bookmark.viewed_at
  end

  test "add_tag_to_bookmark/2 adds a tag to a bookmark" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    {:ok, bookmark_tag} = Bookmarks.add_tag_to_bookmark(bookmark.id, @tag_name)
    updated_bookmark = Bookmarks.get_bookmark!(bookmark.id)

    assert bookmark_tag.post_id == bookmark.id
    assert bookmark.id == updated_bookmark.id
    assert [%Tags.Tag{name: @tag_name}] = updated_bookmark.tags
  end

  test "add_tag_to_bookmark/2 does not add the same tag twice" do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    {:ok, _bookmark_tag} = Bookmarks.add_tag_to_bookmark(bookmark.id, @tag_name)
    {:error, _} = Bookmarks.add_tag_to_bookmark(bookmark.id, @tag_name)
  end
end
