defmodule TomieWeb.JobView do
  use TomieWeb, :view
  alias TomieWeb.JobLive

  def job_duration(%{state: "executing"} = _job) do
    "Running"
  end

  def job_duration(%{state: "discarded"} = _job) do
    "Discarded"
  end

  def job_duration(%{state: "available"} = _job) do
    "Available"
  end

  def job_duration(%{scheduled_at: scheduled_at, completed_at: completed_at}) do
    to_string(Timex.diff(completed_at, scheduled_at, :milliseconds)) <> "ms"
  end

  def state_icon(%{state: state} = _job) do
    case state do
      "completed" -> {:checkmark, "text-on-success"}
      "retryable" -> {:refresh, "text-on-info"}
      "discarded" -> {:close_outline, "text-on-danger"}
      "executing" -> {:cog, ""}
      "available" -> {:coffee, ""}
      _ -> {nil, ""}
    end
  end

  def job_time(nil), do: "empty"
  def job_time(datetime), do: Timex.from_now(datetime)

  def format(nil), do: "empty"
  def format(datetime), do: Timex.format!(datetime, "{D}. {Mfull}, {h24}:{m}:{s}{ss}")
end
