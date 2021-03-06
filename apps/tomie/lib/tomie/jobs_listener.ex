defmodule Tomie.JobsListener do
  use GenServer
  require Logger

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  @impl true
  def init(opts) do
    case Db.Repo.listen("jobs_changed") do
      {:ok, _pid, _ref} -> {:ok, opts}
      error -> {:stop, error}
    end
  end

  @impl true
  def handle_info({:notification, _pid, _ref, "jobs_changed", payload}, _state) do
    case Jason.decode(payload, keys: :atoms) do
      {:ok, data} ->
        %{operation: operation, record: record} = data

        Phoenix.PubSub.broadcast(TomieWeb.PubSub, "Tomie.JobsListener:ALL", %{
          event: :updated,
          operation: operation,
          job_id: record
        })

        {:noreply, :event_handled}

      error ->
        {:stop, error, []}
    end
  end
end
