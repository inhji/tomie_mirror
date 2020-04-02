defmodule BookmarksTest do
  use ExUnit.Case
  doctest Bookmarks

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Db.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Db.Repo, {:shared, self()})
    end

    :ok
  end

  test "create_bookmark/1 creates a new bookmark" do
    bookmark = %{source: "https://inhji.de"}
    assert {:ok, %Bookmarks.Bookmark{}} = Bookmarks.create_bookmark(bookmark)
  end
end
