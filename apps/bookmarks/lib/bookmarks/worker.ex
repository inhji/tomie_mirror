defmodule Bookmarks.Worker do
  use Que.Worker

  def perform(%Bookmarks.Bookmark{source: source} = bookmark) do
    {:ok, html} = Scraper.get_html(source)
    {:ok, result} = Scraper.parse(html)
    Bookmarks.update_bookmark(bookmark, %{title: result.title})
  end
end
