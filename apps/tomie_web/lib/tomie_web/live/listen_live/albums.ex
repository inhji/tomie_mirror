defmodule TomieWeb.ListenLive.Albums do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("albums.html", assigns)

  def mount(_args, _session, socket) do
    {:ok, socket |> assign(albums: fetch())}
  end

  def fetch(),
    do: [
      top: Listens.Report.top(Listens.Albums.Album, 5, [weeks: -2], [:artist]),
      newest: Listens.Albums.list_newest_albums()
    ]
end
