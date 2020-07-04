defmodule TomieWeb.JobLive.Queues do
  use TomieWeb, :live
  alias Tomie.Queues

  def render(assigns), do: TomieWeb.JobView.render("queues.html", assigns)

  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(TomieWeb.PubSub, "Tomie.JobsListener:ALL")
    queues = Queues.list_queues()

    {:ok, socket |> assign(queues: queues)}
  end

  def handle_info(%{event: :updated}, socket) do
    {:noreply, socket |> assign(queues: Queues.list_queues())}
  end

  def handle_event("pause_queue", %{"queue" => queue}, socket) do
    :ok = Oban.pause_queue(queue: queue)

    {:noreply, socket |> put_flash(:info, "Queue #{queue} paused!")}
  end

  def handle_event("resume_queue", %{"queue" => queue}, socket) do
    :ok = Oban.resume_queue(queue: queue)

    {:noreply, socket |> put_flash(:info, "Queue #{queue} resumed!")}
  end
end
