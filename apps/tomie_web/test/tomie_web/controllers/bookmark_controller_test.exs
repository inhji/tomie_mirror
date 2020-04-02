defmodule TomieWeb.BookmarkControllerTest do
  use TomieWeb.ConnCase
  use Bookmarks.Constants

  @source "https://inhji.de"

  @tag :logged_in
  test "GET /bookmarks", %{conn: conn} do
    conn = get(conn, Routes.bookmark_path(conn, :index))
    assert html_response(conn, 200)
  end

  @tag :logged_in
  test "POST /bookmarks", %{conn: conn} do
    conn = post(conn, Routes.bookmark_path(conn, :index), bookmark: %{source: @source})

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.bookmark_path(conn, :show, id)
    assert get_flash(conn, :info) == @bookmark_created
  end

  @tag :logged_in
  test "GET /bookmarks/:id", %{conn: conn} do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    conn = get(conn, Routes.bookmark_path(conn, :show, bookmark.id))

    assert html_response(conn, 200) =~ @source
  end
end
