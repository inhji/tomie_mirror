defmodule TomieWeb.ArtistLive.Show do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ArtistView.render("show.html", assigns)

  def mount(%{"id" => id}, _session, socket) do
    artist = Listens.Artists.get_artist!(id)

    albums =
      artist.albums
      |> Enum.sort(fn a, b -> Enum.count(a.listens) >= Enum.count(b.listens) end)
      |> Enum.map(fn a ->
        image = Listens.Albums.get_album_image(a, :large)

        %{
          item: a,
          image: image
        }
      end)

    image = Listens.Artists.get_artist_image(artist, :large)

    {:ok,
     socket
     |> assign(
       artist: artist,
       albums: albums,
       image: image,
       page_title: artist.name
     )}
  end
end
