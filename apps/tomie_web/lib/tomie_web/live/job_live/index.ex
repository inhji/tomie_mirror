defmodule TomieWeb.JobLive.Index do
  use TomieWeb, :live
  alias TomieWeb.JobView
  alias Tomie.Jobs

  def render(assigns), do: JobView.render("index.html", assigns)

  def mount(_args, _session, socket) do
    Phoenix.PubSub.subscribe(TomieWeb.PubSub, "Tomie.JobsListener:ALL")
    {:ok, socket}
  end

  defp fetch(nil), do: Jobs.list_jobs()
  defp fetch(%{state: state}), do: Jobs.list_jobs_by_state(state)
  defp fetch(%{queue: queue}), do: Jobs.list_jobs_by_queue(queue)

  def handle_info(
        %{event: :updated, job_id: _job_id, operation: _op},
        %{assigns: %{page: page}} = socket
      ) do
    {:noreply, socket |> assign(jobs: fetch(%{page: page}))}
  end

  def handle_info(
        %{event: :updated, job_id: _job_id, operation: _op},
        %{assigns: %{queue: queue}} = socket
      ) do
    {:noreply, socket |> assign(jobs: fetch(%{queue: queue}))}
  end

  def handle_info(%{event: :updated, job_id: _job_id, operation: _op}, socket) do
    {:noreply, socket |> assign(jobs: fetch(nil))}
  end

  def handle_params(%{"state" => state}, _url, socket) do
    jobs = fetch(%{state: state})
    {:noreply, socket |> assign(jobs: jobs, state: state)}
  end

  def handle_params(_params, _url, socket) do
    jobs = fetch(nil)
    {:noreply, socket |> assign(jobs: jobs, state: nil)}
  end
end
