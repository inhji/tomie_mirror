defmodule TomieWeb.PageControllerTest do
  use TomieWeb.ConnCase

  @tag :logged_in
  test "GET /", %{conn: conn} do
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200)
  end
end
