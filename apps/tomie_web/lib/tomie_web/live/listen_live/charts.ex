defmodule TomieWeb.ListenLive.Charts do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("charts.html", assigns)

  def mount(_args, _session, socket) do
    {:ok, socket |> assign(fetch())}
  end

  def fetch(),
    do: [
      last_two_weeks:
        Listens.Report.listens_within_range(days: -14)
        |> Enum.group_by(fn l -> l.artist.name end)
        |> Enum.map(fn {name, listens} -> {name, Enum.count(listens)} end)
        |> Enum.sort_by(fn {_name, listens} -> listens end)
        |> Enum.reverse()
        |> Enum.take(10)
        |> Enum.map(fn {name, listens} -> [name, listens] end)
        |> Jason.encode!()
    ]
end
