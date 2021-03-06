defmodule TomieWeb.ListenLive.Index do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("index.html", assigns)

  def mount(_args, _session, socket) do
    Phoenix.PubSub.subscribe(TomieWeb.PubSub, "Listens.Workers:ALL")
    {:ok, socket |> assign(fetch() ++ [page_title: "Listens"])}
  end

  def handle_info(%{event: :updated}, socket) do
    {:noreply, socket}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def fetch(),
    do: [listens: Listens.Listens.list_listens()]
end
