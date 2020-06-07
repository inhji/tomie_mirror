defmodule TomieWeb.HomeController do
  use TomieWeb, :controller

  def index(conn, _params) do
  	bookmarks = Bookmarks.list_bookmarks("", "recent", 3)
  	listens = Listens.Listens.list_listens(3)

    conn
    |> put_layout("home.html")
    |> render("index.html", bookmarks: bookmarks, listens: listens)
  end
end
