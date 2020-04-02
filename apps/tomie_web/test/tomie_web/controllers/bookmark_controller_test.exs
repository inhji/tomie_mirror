defmodule TomieWeb.BookmarkControllerTest do
  use TomieWeb.ConnCase
  use Bookmarks.Constants

  @tag :logged_in
  test "GET /bookmarks", %{conn: conn} do
    conn = get(conn, Routes.bookmark_path(conn, :index))
    assert html_response(conn, 200)
  end

  @tag :logged_in
  test "POST /bookmarks", %{conn: conn} do
    conn = post(conn, Routes.bookmark_path(conn, :index), bookmark: %{source: "https://inhji.de"})
    assert redirected_to(conn) == Routes.bookmark_path(conn, :index)
    assert get_flash(conn, :info) == @bookmark_created
  end
end
