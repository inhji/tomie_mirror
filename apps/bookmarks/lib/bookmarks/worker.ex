defmodule Bookmarks.Worker do
  use Que.Worker

  def perform(%Bookmarks.Bookmark{source: source} = bookmark) do
    {:ok, html} = Scraper.get_html(source)
    {:ok, result} = Scraper.parse(html)

    Tags.list_tags()
    |> Enum.filter(fn %{rules: rules} -> not is_nil(rules) end)
    |> Tags.Rules.parse(bookmark)
    |> Bookmarks.update_tags(bookmark)

    Bookmarks.update_bookmark(bookmark, %{title: result.title})
  end
end
