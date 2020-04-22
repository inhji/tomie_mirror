defmodule TomieWeb.JobLive.Index do
  use TomieWeb, :live
  alias TomieWeb.JobView

  def render(assigns), do: JobView.render("index.html", assigns)

  def mount(_args, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"page" => page}, _url, socket) do
    jobs =
      page
      |> String.to_existing_atom()
      |> Tomie.Jobs.list_jobs()

    {:noreply, socket |> assign(jobs: jobs)}
  end

  def handle_params(_params, _url, socket) do
    jobs = Tomie.Jobs.list_jobs()
    {:noreply, socket |> assign(jobs: jobs)}
  end
end
