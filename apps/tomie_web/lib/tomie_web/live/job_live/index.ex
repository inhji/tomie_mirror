defmodule TomieWeb.JobLive.Index do
  use TomieWeb, :live
  alias TomieWeb.JobView

  def render(assigns), do: JobView.render("index.html", assigns)

  def mount(_args, _session, socket) do
    jobs = Tomie.Jobs.list_jobs()

    {:ok, socket |> assign(jobs: jobs)}
  end
end
