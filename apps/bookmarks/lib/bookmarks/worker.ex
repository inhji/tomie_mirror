defmodule Bookmarks.Worker do
  use Oban.Worker,
    queue: :bookmarks,
    max_attempts: 5

  alias Bookmarks.Bookmark

  @impl Oban.Worker
  def perform(%{"id" => id, "url" => url}, _job) do
    bookmark = Bookmarks.get_bookmark!(id)

    with :ok <- scrape_bookmark_url(bookmark),
         :ok <- send_webmention(bookmark, url) do
      :ok
    else
      error -> error
    end
  end

  def scrape_bookmark_url(%Bookmark{source: source} = bookmark) do
    with {:ok, html} <- Scraper.Html.get_html(source),
         {:ok, result} <- Scraper.Html.parse(html),
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
      _ -> {:error, "scrape error"}
    end
  end

  def send_webmention(%Bookmark{source: destination}, source_url) do
    with {:ok, endpoint} <- Webmentions.discover_endpoint(destination),
         :ok <- Webmentions.send_webmention(endpoint, source_url, destination) do
      :ok
    else
      {:ok, nil} -> {:error, "No endpoint found"}
      {:ok, ""} -> {:error, "No endpoint found"}
      {:error, status} when is_number(status) -> {:error, "Failed with status #{status}"}
      {:error, message} -> {:error, message}
    end
  end
end
