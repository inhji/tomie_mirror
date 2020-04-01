defmodule TomieWeb.PageControllerTest do
  use TomieWeb.ConnCase

  # See: https://elixirforum.com/t/controller-test-with-pow/18926/2
  setup %{conn: conn} do
    user = %Tomie.Users.User{email: "test@example.com", id: 1}
    authed_conn = Pow.Plug.assign_current_user(conn, user, [])

    {:ok, conn: authed_conn}
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Tomie"
  end
end
