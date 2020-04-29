defmodule TomieWeb.AlbumLive.Show do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.AlbumView.render("show.html", assigns)

  def mount(%{"id" => id}, _session, socket) do
    album = Listens.Albums.get_album!(id)
    image = Listens.Albums.get_album_image(album, :large)

    {:ok,
     socket
     |> assign(
       album: album,
       image: image
     )}
  end
end
