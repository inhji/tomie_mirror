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
      chart_data:
        Listens.Report.listens_over_time("YYYY-mm-dd", days: -21)
        |> Enum.map(&prepare_data/1)
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
