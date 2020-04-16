defmodule TomieWeb.BookmarkLive.New do
  use TomieWeb, :live
  alias Bookmarks.Bookmark
  alias TomieWeb.{BookmarkLive, BookmarkView}

  def render(assigns), do: BookmarkView.render("new.html", assigns)

  def mount(%{"content" => content, "name" => name, "url" => url}, _session, socket) do
    changeset =
      Bookmark.changeset(%Bookmark{}, %{
        title: name,
        content: content,
        source: url
      })

    {:ok, assign(socket, changeset: changeset)}
  end

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

  def handle_event("save", %{"bookmark" => %{"tag_string" => tags} = params}, socket) do
    case Bookmarks.create_bookmark(params) do
      {:ok, bookmark} ->
        Bookmarks.set_tags(tags, bookmark)
        TomieWeb.Worker.run(bookmark)

        {:noreply,
         push_redirect(socket, to: Routes.live_path(socket, BookmarkLive.Show, bookmark))}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
