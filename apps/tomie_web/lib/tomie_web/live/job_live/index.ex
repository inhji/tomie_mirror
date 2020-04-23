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
  defp fetch(page), do: String.to_existing_atom(page) |> Jobs.list_jobs()

  def handle_info(
        %{event: :updated, job: job, operation: operation},
        %{assigns: %{page: page}} = socket
      ) do
    {:noreply, socket |> assign(jobs: fetch(page))}
  end

  def handle_params(%{"page" => page}, _url, socket) do
    jobs = fetch(page)
    {:noreply, socket |> assign(jobs: jobs, page: page)}
  end

  def handle_params(_params, _url, socket) do
    jobs = fetch(nil)
    {:noreply, socket |> assign(jobs: jobs, page: nil)}
  end
end
