defmodule TomieWeb.ListenLive.Albums do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("albums.html", assigns)

  def mount(_args, _session, socket) do
    {:ok, socket |> assign(artists: fetch())}
  end

  def fetch(), do: Listens.Report.top(Listens.Albums.Album, 10, weeks: -2)
end
