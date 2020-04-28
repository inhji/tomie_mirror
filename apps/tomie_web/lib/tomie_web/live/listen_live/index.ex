defmodule TomieWeb.ListenLive.Index do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("index.html", assigns)

  def mount(_args, _session, socket) do
    Phoenix.PubSub.subscribe(TomieWeb.PubSub, "Listens.Workers:ALL")
    {:ok, socket |> assign(fetch())}
  end

  def handle_info(%{event: :updated}, socket) do
    {:noreply, socket |> assign(fetch())}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def fetch() do
    [
      listens: Listens.Listens.list_listens(),
      sparkline:
        Listens.Report.listens_over_time("YYYY-mm-dd", months: -1)
        |> Enum.map(fn %{count: c, date: d} -> [d, c] end)
        |> IO.inspect()
    ]
  end
end
