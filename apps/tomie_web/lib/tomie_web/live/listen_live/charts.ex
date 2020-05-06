defmodule TomieWeb.ListenLive.Charts do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("charts.html", assigns)

  def mount(_args, _session, socket) do
    {:ok, socket |> assign(fetch())}
  end

  def fetch(),
    do: [
      last_two_weeks:
        Listens.Report.top(Listens.Artists.Artist, 10, days: -14)
        |> Enum.map(fn %{listens: listens, model: artist} -> [artist.name, listens] end)
        |> Jason.encode!()
    ]
end
