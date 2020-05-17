defmodule TomieWeb.AlbumLive.Merge do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.AlbumView.render("merge.html", assigns)

  def mount(%{"id" => id}, _session, socket) do
    album = Listens.Albums.get_album!(id)
    image = Listens.Albums.get_album_image(album, :large)

    albums =
      album.artist.id
      |> Listens.Artists.get_artist!()
      |> Map.get(:albums)
      |> Enum.filter(fn a -> a.id != album.id end)

    {:ok,
     socket
     |> assign(
       albums: albums,
       old_album: album,
       old_image: image,
       new_album: nil,
       new_image: nil,
       page_title: "Merge #{album.name}"
     )}
  end

  def handle_event("change_album", %{"album" => album_id}, socket) do
    album = Listens.Albums.get_album!(album_id)
    image = Listens.Albums.get_album_image(album, :large)
    {:noreply, assign(socket, new_album: album, new_image: image)}
  end

  def handle_event("do_merge", _value, socket) do
    old_album_id = socket.assigns.old_album.id
    new_album_id = socket.assigns.new_album.id

    case Listens.Merge.merge_album(old_album_id, new_album_id) do
      {:ok, _result} ->
        {:noreply,
         push_redirect(socket, to: Routes.live_path(socket, TomieWeb.AlbumLive.Show, new_album_id))}

      _ ->
        {:noreply, socket}
    end
  end
end
