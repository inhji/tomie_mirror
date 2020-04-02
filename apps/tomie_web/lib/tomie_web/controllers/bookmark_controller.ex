defmodule TomieWeb.BookmarkController do
  use TomieWeb, :controller

  def index(conn, _params) do
    bookmarks = Bookmarks.list_bookmarks()

    render(conn, "index.html", bookmarks: bookmarks)
  end
end
