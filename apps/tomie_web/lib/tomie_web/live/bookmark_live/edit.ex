defmodule TomieWeb.BookmarkLive.Edit do
  use TomieWeb, :live
  alias Bookmarks.Bookmark
  alias TomieWeb.{BookmarkLive, BookmarkView}

  def render(assigns), do: BookmarkView.render("edit.html", assigns)
  def mount(_params, _session, socket), do: {:ok, socket}

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  def fetch(%{assigns: %{id: id}} = socket) do
    bookmark = Bookmarks.get_bookmark!(id)
    assign(socket, bookmark: bookmark, changeset: Bookmark.changeset(bookmark))
  end

  def handle_event("validate", %{"bookmark" => params}, socket) do
    changeset =
      %Bookmark{}
      |> Bookmark.changeset(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"bookmark" => params}, socket) do
    case Bookmarks.update_bookmark(socket.assigns.bookmark, params) do
      {:ok, bookmark} ->
        {:noreply,
         push_redirect(socket, to: Routes.live_path(socket, BookmarkLive.Show, bookmark))}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
