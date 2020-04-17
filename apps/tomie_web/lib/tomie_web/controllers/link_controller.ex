defmodule TomieWeb.LinkController do
  use TomieWeb, :controller

  def redirect(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)
    {:ok, _visited_bookmark} = Bookmarks.visit_bookmark(bookmark)

    Phoenix.Controller.redirect(conn, external: bookmark.source)
  end
end
