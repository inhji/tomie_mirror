defmodule TomieWeb.JobView do
  use TomieWeb, :view
  alias TomieWeb.JobLive

  def job_duration(%{scheduled_at: scheduled_at, completed_at: completed_at} = _job) do
    Timex.diff(completed_at, scheduled_at, :milliseconds)
  end

  def job_time(nil), do: "empty"
  def job_time(datetime), do: Timex.from_now(datetime)

  def format(nil), do: "empty"
  def format(datetime), do: Timex.format!(datetime, "{h24}:{m}:{s}{ss}")
end
