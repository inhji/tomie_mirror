defmodule TomieWeb.ListenLive.Artists do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("artists.html", assigns)

  def mount(_args, _session, socket) do
    {:ok, socket |> assign(artists: fetch())}
  end

  def fetch(),
    do: [
      top: Listens.Report.top(Listens.Artists.Artist, 5, weeks: -2),
      newest: Listens.Artists.list_newest_artists()
    ]
end
