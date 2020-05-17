defmodule TomieWeb.AlbumView do
  use TomieWeb, :view

  def last_listen(album) do
    album.listens
    |> Enum.sort(fn a, b ->
      DateTime.compare(a.listened_at, b.listened_at) == :gt
    end)
    |> Enum.at(0)
    |> Map.get(:listened_at)
    |> Timex.from_now()
  end

  def discogs_link(album) do
    search_text = URI.encode("#{album.artist.name} #{album.name}")

    missing_link =
      link("Missing/Search",
        target: "_blank",
        to: "https://www.discogs.com/search/?type=all&q=#{search_text}"
      )

    case album.discogs_id do
      nil ->
        missing_link

      -1 ->
        missing_link

      discogs_id ->
        link(discogs_id, target: "_blank", to: "https://www.discogs.com/release/#{discogs_id}")
    end
  end
end
