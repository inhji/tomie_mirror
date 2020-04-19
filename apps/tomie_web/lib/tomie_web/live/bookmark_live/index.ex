defmodule TomieWeb.BookmarkLive.Index do
  use TomieWeb, :live
  use Phoenix.HTML

  def render(assigns), do: TomieWeb.BookmarkView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(changeset: changeset(), query: "")}
  end

  def handle_params(%{"page" => page}, _url, socket) do
    bookmarks = Bookmarks.list_bookmarks(socket.assigns.query, page)

    {:noreply,
     socket
     |> assign(
       page: page,
       bookmarks: bookmarks
     )}
  end

  def handle_params(_params, _url, socket) do
    {:noreply,
     socket
     |> push_patch(to: Routes.live_path(socket, TomieWeb.BookmarkLive.Index, page: "recent"))}
  end

  def handle_event("search", %{"search" => %{"query" => query}}, socket) do
    bookmarks = Bookmarks.list_bookmarks(query, socket.assigns.page)

    {:noreply,
     socket
     |> assign(
       bookmarks: bookmarks,
       changeset: changeset(%{query: query})
     )}
  end

  def changeset(attrs \\ %{}) do
    types = %{query: :string}

    {%{}, types}
    |> Ecto.Changeset.cast(attrs, Map.keys(types))
  end
end
