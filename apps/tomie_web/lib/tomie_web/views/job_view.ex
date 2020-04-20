defmodule TomieWeb.JobView do
  use TomieWeb, :view

  def job_duration(%{scheduled_at: scheduled_at, completed_at: completed_at} = job) do
    Timex.diff(completed_at, scheduled_at, :milliseconds)
  end
end
