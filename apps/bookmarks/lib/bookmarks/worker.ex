defmodule Bookmarks.Worker do
  use Que.Worker

  def perform(%Bookmarks.Bookmark{source: source} = bookmark) do
    {:ok, html} = Scraper.get_html(source)

    title = Scraper.get_title!(html)
    Bookmarks.update_bookmark(bookmark, %{title: title})
  end
end
