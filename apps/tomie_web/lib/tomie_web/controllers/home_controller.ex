defmodule TomieWeb.HomeController do
  use TomieWeb, :controller

  plug :with_home_layout

  def index(conn, _params) do
    bookmarks = Bookmarks.list_bookmarks("", "recent", 3)
    listens = Listens.Listens.list_listens(3)
    user = Tomie.Users.get_user!(1)

    conn
    |> render("index.html",
      bookmarks: bookmarks,
      listens: listens,
      page_title: "Home",
      user: user
    )
  end

  def project(conn, %{"name" => name}) do
    pretty_name = String.capitalize(name)

    render(conn, "project_#{name}.html", page_title: pretty_name)
  end

  def bookmark(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)

    render(conn, "bookmark.html", bookmark: bookmark, page_title: bookmark.title)
  end

  defp with_home_layout(conn, _opts), do: put_layout(conn, "home.html")
end
