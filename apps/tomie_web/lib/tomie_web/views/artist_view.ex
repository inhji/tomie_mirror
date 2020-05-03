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
end
