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
    with {:ok, _pid, _ref} <- Db.Repo.listen("jobs_changed") do
      {:ok, opts}
    else
      error -> {:stop, error}
    end
  end

  @impl true
  def handle_info({:notification, _pid, _ref, "jobs_changed", payload}, _state) do
    with {:ok, data} <- Jason.decode(payload, keys: :atoms),
         %{operation: operation, record: record} <- data do
      data
      |> inspect()
      |> Logger.info()

      Phoenix.PubSub.broadcast(TomieWeb.PubSub, "Tomie.JobsListener:ALL", %{
        event: :updated,
        operation: operation,
        job: record
      })

      {:noreply, :event_handled}
    else
      error -> {:stop, error, []}
    end
  end
end
