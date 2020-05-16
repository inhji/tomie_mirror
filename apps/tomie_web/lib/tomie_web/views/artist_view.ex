defmodule TomieWeb.ArtistView do
  use TomieWeb, :view

  def last_listen(artist) do
    artist.listens
    |> Enum.sort(fn a, b ->
      DateTime.compare(a.listened_at, b.listened_at) == :gt
    end)
    |> Enum.at(0)
    |> Map.get(:listened_at)
    |> Timex.from_now()
  end

  def discogs_link(artist) do
    case artist.discogs_id do
      nil ->
        "Missing"

      discogs_id ->
        link(discogs_id, target: "_blank", to: "https://www.discogs.com/artist/#{discogs_id}")
    end
  end
end
