defmodule TomieWeb.JobView do
  use TomieWeb, :view
  alias TomieWeb.JobLive

  def job_duration(%{scheduled_at: _scheduled_at, completed_at: nil} = _job) do
    "Running"
  end

  def job_duration(%{scheduled_at: scheduled_at, completed_at: completed_at} = _job) do
    to_string(Timex.diff(completed_at, scheduled_at, :milliseconds)) <> "ms"
  end

  def job_time(nil), do: "empty"
  def job_time(datetime), do: Timex.from_now(datetime)

  def format(nil), do: "empty"
  def format(datetime), do: Timex.format!(datetime, "{D}. {Mfull}, {h24}:{m}:{s}{ss}")
end
