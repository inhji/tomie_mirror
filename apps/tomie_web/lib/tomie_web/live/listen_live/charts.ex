defmodule TomieWeb.ListenLive.Charts do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("charts.html", assigns)

  def mount(_args, _session, socket) do
    {:ok, socket |> assign(fetch())}
  end

  def fetch(),
    do: [
      page_title: "Charts",
      last_two_weeks:
        Listens.Artists.Artist
        |> Listens.Report.top(6, weeks: -2)
        |> Enum.map(fn %{model: artist, listens: _l} ->
          %{name: artist.name, data: Listens.Report.by_day(artist.id, days: 14)}
        end)
        |> Jason.encode!()
    ]
end
