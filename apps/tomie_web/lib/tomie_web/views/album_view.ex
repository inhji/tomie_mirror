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
    case album.discogs_id do
      nil ->
        "Missing"

      discogs_id ->
        link(discogs_id, target: "_blank", to: "https://www.discogs.com/release/#{discogs_id}")
    end
  end
end
