defmodule TomieWeb.ListenLive.Index do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("index.html", assigns)

  def mount(_args, _session, socket) do
    Phoenix.PubSub.subscribe(TomieWeb.PubSub, "Listens.Workers:ALL")
    {:ok, socket |> assign(fetch())}
  end

  def handle_info(%{event: :updated}, socket) do
    {:noreply, socket}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def fetch(),
    do: [
      listens: Listens.Listens.list_listens(),
      last_two_weeks:
        Listens.Report.listens_within_range(days: -14)
        |> Enum.group_by(fn l -> l.artist.name end)
        |> Enum.map(fn {name, listens} -> {name, Enum.count(listens)} end)
        |> Enum.sort_by(fn {_name, listens} -> listens end)
        |> Enum.reverse()
        |> Enum.take(10)
        |> Enum.map(fn {name, listens} -> [name, listens] end)
        |> IO.inspect()
        |> Jason.encode!()
    ]

  defp prepare_data(%{count: count, date: date}) do
    formatted_date =
      date
      |> Timex.parse!("{YYYY}-{0M}-{D}")
      |> Timex.format!("{0D}/{0M}")

    [formatted_date, count]
  end
end
