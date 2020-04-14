defmodule TomieWeb.BookmarkLive.Visit do
  use TomieWeb, :live
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
    You are being redirected!
    """
  end

  def mount(%{"id" => id}, _session, socket) do
    bookmark = Bookmarks.get_bookmark!(id)
    {:ok, _visited_bookmark} = Bookmarks.visit_bookmark(bookmark)
    {:ok, socket |> redirect(external: bookmark.source)}
  end
end
