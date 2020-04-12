defmodule TomieWeb.TagControllerTest do
  use TomieWeb.ConnCase
  use Tags.Constants

  @some_tag %{name: "some tag"}
  @some_other_tag %{name: "some tag", rules: "foobar"}

  @tag :logged_in
  test "GET /tags", %{conn: conn} do
    conn = get(conn, Routes.tag_path(conn, :index))
    assert html_response(conn, 200)
  end

  @tag :logged_in
  test "GET /tags/new", %{conn: conn} do
    conn = get(conn, Routes.tag_path(conn, :new))
    assert html_response(conn, 200)
  end

  @tag :logged_in
  test "GET /tags/:id/edit", %{conn: conn} do
    {:ok, tag} = Tags.create_tag(@some_tag)

    conn = get(conn, Routes.tag_path(conn, :edit, tag))
    assert html_response(conn, 200)
  end

  @tag :logged_in
  test "POST /tags", %{conn: conn} do
    conn = post(conn, Routes.tag_path(conn, :create), tag: @some_tag)

    assert %{} = redirected_params(conn)
    assert redirected_to(conn) == Routes.tag_path(conn, :index)
    assert get_flash(conn, :info) == @tag_created
  end

  @tag :logged_in
  test "GET /tags/:id", %{conn: conn} do
    {:ok, tag} = Tags.create_tag(@some_tag)
    conn = get(conn, Routes.tag_path(conn, :show, tag.id))

    assert html_response(conn, 200) =~ "some tag"
  end

  @tag :logged_in
  test "POST /tags/:id", %{conn: conn} do
    {:ok, tag} = Tags.create_tag(@some_tag)

    conn = put(conn, Routes.tag_path(conn, :update, tag), tag: @some_other_tag)

    assert %{} = redirected_params(conn)
    assert redirected_to(conn) == Routes.tag_path(conn, :index)
  end
end
