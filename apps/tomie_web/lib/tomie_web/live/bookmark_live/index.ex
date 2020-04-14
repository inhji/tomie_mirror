defmodule TomieWeb.BookmarkLive.Index do
  use TomieWeb, :live
  use Phoenix.HTML

  def render(assigns), do: TomieWeb.BookmarkView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    bookmarks = Bookmarks.list_bookmarks(10)

    {:ok, assign(socket, changeset: changeset(), bookmarks: bookmarks)}
  end

  def handle_event("search", %{"search" => %{"query" => query}}, socket) do
    bookmarks = Bookmarks.query_bookmarks(query)

    {:noreply, assign(socket, bookmarks: bookmarks)}
  end

  def changeset(attrs \\ %{}) do
    types = %{query: :string}

    {%{}, types}
    |> Ecto.Changeset.cast(attrs, Map.keys(types))
    |> Ecto.Changeset.validate_required([:query])
  end
end
