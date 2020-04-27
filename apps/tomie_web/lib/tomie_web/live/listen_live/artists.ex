defmodule TomieWeb.ListenLive.Artists do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("artists.html", assigns)

  def mount(_args, _session, socket) do
    {:ok, socket |> assign(artists: fetch())}
  end

  def fetch(), do: Listens.Report.top(Listens.Artists.Artist, 10, weeks: -1)
end
