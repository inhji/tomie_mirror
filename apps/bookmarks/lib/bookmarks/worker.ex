defmodule Bookmarks.Worker do
  use Oban.Worker,
    queue: :default,
    max_attempts: 5

  @impl Oban.Worker
  def perform(%{"id" => id}, _job) do
    with bookmark <- Bookmarks.get_bookmark!(id),
         source <- Map.get(bookmark, :source),
         {:ok, html} <- Scraper.get_html(source),
         {:ok, result} <- Scraper.parse(html),
         {:ok, updated_bookmark} <- Bookmarks.update_bookmark(bookmark, %{title: result.title}) do
      {:ok, updated_bookmark} =
        Tags.list_tags_with_rules()
        |> Tags.Rules.parse(updated_bookmark)
        |> Bookmarks.update_tags(updated_bookmark)

      Phoenix.PubSub.broadcast(TomieWeb.PubSub, "Bookmarks.Worker:#{bookmark.id}", %{
        event: :updated,
        bookmark: updated_bookmark
      })

      :ok
    else
      _ -> :error
    end
  end
end
