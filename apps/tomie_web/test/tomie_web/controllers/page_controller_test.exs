defmodule TomieWeb.PageControllerTest do
  use TomieWeb.ConnCase

  @tag :logged_in
  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end
end
