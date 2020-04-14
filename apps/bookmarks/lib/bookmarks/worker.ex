defmodule Bookmarks.Worker do
  use Que.Worker, concurrency: 4

  def perform(%Bookmarks.Bookmark{source: source} = bookmark) do
    with {:ok, html} <- Scraper.get_html(source),
         {:ok, result} <- Scraper.parse(html),
         {:ok, updated_bookmark} <- Bookmarks.update_bookmark(bookmark, %{title: result.title}) do
      Tags.list_tags_with_rules()
      |> Tags.Rules.parse(updated_bookmark)
      |> Bookmarks.update_tags(updated_bookmark)

      :ok
    else
      _ -> :error
    end
  end
end
