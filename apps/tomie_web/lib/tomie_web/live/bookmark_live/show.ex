defmodule TomieWeb.BookmarkLive.Show do
  use TomieWeb, :live
  alias TomieWeb.{BookmarkLive, BookmarkView}

  def render(assigns), do: BookmarkView.render("show.html", assigns)

  def mount(%{"id" => id}, _session, socket) do
    Phoenix.PubSub.subscribe(TomieWeb.PubSub, "Bookmarks.Worker:#{id}")

    {:ok, socket}
  end

  def handle_info(%{event: :updated, bookmark: bookmark}, socket) do
    {:noreply, socket |> assign(bookmark: bookmark)}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  def fetch(%{assigns: %{id: id}} = socket) do
    assign(socket, bookmark: Bookmarks.get_bookmark!(id))
  end

  def handle_event("toggle_favorite", %{"id" => id}, socket) do
    {:ok, bookmark} =
      id
      |> Bookmarks.get_bookmark!()
      |> Bookmarks.toggle_bookmark_flag(:is_favorite)

    {:noreply, socket |> assign(bookmark: bookmark)}
  end

  def handle_event("toggle_archived", %{"id" => id}, socket) do
    {:ok, bookmark} =
      id
      |> Bookmarks.get_bookmark!()
      |> Bookmarks.toggle_bookmark_flag(:is_archived)

    {:noreply, socket |> assign(bookmark: bookmark)}
  end

  def handle_event("delete_bookmark", %{"id" => id}, socket) do
    Bookmarks.get_bookmark!(id)
    |> Bookmarks.delete_bookmark()

    {:noreply, push_redirect(socket, to: Routes.live_path(socket, BookmarkLive.Index))}
  end
end
