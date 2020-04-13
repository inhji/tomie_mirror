defmodule TomieWeb.BookmarkLive.New do
  use TomieWeb, :live
  alias Bookmarks.Bookmark
  alias TomieWeb.{BookmarkLive, BookmarkView}

  def render(assigns), do: BookmarkView.render("new.html", assigns)

  def mount(_params, _session, socket) do
    changeset = Bookmark.changeset(%Bookmark{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def handle_event("validate", %{"bookmark" => params}, socket) do
    changeset =
      %Bookmark{}
      |> Bookmark.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"bookmark" => params}, socket) do
    case Bookmarks.create_bookmark(params) do
      {:ok, bookmark} ->
        TomieWeb.Worker.run(bookmark)

        {:noreply,
         push_redirect(socket, to: Routes.live_path(socket, BookmarkLive.Show, bookmark))}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
