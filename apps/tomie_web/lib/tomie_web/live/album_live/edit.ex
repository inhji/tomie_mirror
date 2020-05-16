defmodule TomieWeb.AlbumLive.Edit do
  use TomieWeb, :live
  alias Listens.Albums.Album
  alias TomieWeb.{AlbumLive, AlbumView}

  def render(assigns), do: AlbumView.render("edit.html", assigns)
  def mount(_params, _session, socket), do: {:ok, socket}

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  def fetch(%{assigns: %{id: id}} = socket) do
    album = Listens.Albums.get_album!(id)

    assign(socket,
      album: album,
      changeset: Album.changeset(album),
      page_title: "Edit #{album.name}"
    )
  end

  def handle_event("validate", %{"album" => params}, socket) do
    changeset =
      %Album{}
      |> Album.changeset(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"album" => params}, socket) do
    case Listens.Albums.update_album(socket.assigns.album, params) do
      {:ok, album} ->
        {:noreply, push_redirect(socket, to: Routes.live_path(socket, AlbumLive.Show, album))}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
