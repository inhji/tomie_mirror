defmodule TomieWeb.ProfileControllerTest do
  use TomieWeb.ConnCase

  @tag :logged_in
  test "GET /", %{conn: conn} do
    conn = get(conn, Routes.profile_path(conn, :show))
    assert html_response(conn, 200)
  end

  @tag :logged_in
  test "GET /profile/edit", %{conn: conn} do
    conn = get(conn, Routes.profile_path(conn, :edit))
    assert html_response(conn, 200)
  end

  @tag :logged_in
  test "POST /profile", %{conn: conn} do
    config = Application.get_env(:tomie_web, :pow)
    params = %{user: %{theme: "dark"}}

    {:ok, user} =
      Pow.Operations.create(
        %{
          email: "test@example.com",
          password: "123456789",
          password_confirmation: "123456789",
          token: "token"
        },
        config
      )

    conn =
      conn
      |> Pow.Plug.put_config(config)
      |> Pow.Plug.assign_current_user(user, [])
      |> put(Routes.profile_path(conn, :update), params)

    assert redirected_to(conn) == Routes.profile_path(conn, :show)
  end
end
