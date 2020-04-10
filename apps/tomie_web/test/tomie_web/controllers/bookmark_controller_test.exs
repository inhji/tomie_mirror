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
  test "GET /bookmarks/new", %{conn: conn} do
    conn = get(conn, Routes.bookmark_path(conn, :new))
    assert html_response(conn, 200)
  end

  @tag :logged_in
  test "GET /bookmarks/:id/edit", %{conn: conn} do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    conn = get(conn, Routes.bookmark_path(conn, :edit, bookmark))
    assert html_response(conn, 200)
  end

  @tag :logged_in
  test "POST /bookmarks/:id", %{conn: conn} do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})

    params = %{bookmark: %{source: "https://new_source.de"}}
    conn = put(conn, Routes.bookmark_path(conn, :update, bookmark), params)

    assert redirected_to(conn) == Routes.bookmark_path(conn, :index)
  end

  @tag :logged_in
  test "GET /bookmarks/:id", %{conn: conn} do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    conn = get(conn, Routes.bookmark_path(conn, :show, bookmark.id))

    assert html_response(conn, 200) =~ @source
  end

  @tag :logged_in
  test "GET /bookmarks/:id/visit", %{conn: conn} do
    {:ok, bookmark} = Bookmarks.create_bookmark(%{source: @source})
    conn = get(conn, Routes.bookmark_path(conn, :visit, bookmark.id))

    updated_bookmark = Bookmarks.get_bookmark!(bookmark.id)

    assert redirected_to(conn) == @source
    assert bookmark.views + 1 == updated_bookmark.views
  end

  @tag :logged_in
  test "GET /bookmarks/bookmarklet", %{conn: conn} do
    conn =
      get(conn, Routes.bookmark_path(conn, :bookmarklet), %{
        url: @source,
        token: Pow.Plug.current_user(conn).token
      })

    assert redirected_to(conn) == @source
  end
end
