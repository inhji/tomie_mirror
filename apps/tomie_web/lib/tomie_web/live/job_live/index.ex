defmodule TomieWeb.JobLive.Index do
  use TomieWeb, :live
  alias TomieWeb.JobView
  alias Tomie.Jobs

  def render(assigns), do: JobView.render("index.html", assigns)

  def mount(_args, _session, socket) do
    Phoenix.PubSub.subscribe(TomieWeb.PubSub, "Tomie.JobsListener:ALL")
    {:ok, assign(socket, page_title: "Jobs", stats: fetch_stats())}
  end

  defp fetch(nil), do: Jobs.list_jobs()
  defp fetch(%{state: state}), do: Jobs.list_jobs_by_state(state)
  defp fetch(%{queue: queue}), do: Jobs.list_jobs_by_queue(queue)

  defp fetch_stats do
    %{
      listenbrainz: %{
        rate_limit: Listens.Cache.try_get(:listenbrainz, :rate_limit, %{remaining: 0, total: 0}),
        fetch_listen_count: Listens.Cache.try_get(:listenbrainz, :fetch_listen_count, 0),
        last_listen_timestamp: Listens.Cache.try_get(:listenbrainz, :last_listen_timestamp, 0)
      },
      discogs: %{
        rate_limit: Listens.Cache.try_get(:discogs, :rate_limit, %{remaining: 0, total: 0}),
        last_updated: Listens.Cache.try_get(:discogs, :last_updated, 0)
      }
    }
  end

  def handle_info(:heartbeat, socket) do
    {:noreply, socket |> assign(stats: fetch_stats())}
  end

  def handle_info(
        %{event: :updated, job_id: _job_id, operation: _op},
        %{assigns: %{page: page}} = socket
      ) do
    {:noreply, socket |> assign(jobs: fetch(%{page: page}), stats: fetch_stats())}
  end

  def handle_info(
        %{event: :updated, job_id: _job_id, operation: _op},
        %{assigns: %{queue: queue}} = socket
      ) do
    {:noreply, socket |> assign(jobs: fetch(%{queue: queue}), stats: fetch_stats())}
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
