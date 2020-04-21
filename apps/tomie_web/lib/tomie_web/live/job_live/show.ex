defmodule TomieWeb.JobLive.Show do
  use TomieWeb, :live
  alias TomieWeb.JobView

  def render(assigns), do: JobView.render("show.html", assigns)

  def mount(%{"id" => id}, _session, socket) do
    job = Tomie.Jobs.get_job!(id)
    {:ok, socket |> assign(job: job)}
  end
end
