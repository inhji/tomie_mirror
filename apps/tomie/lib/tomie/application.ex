defmodule Tomie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Tomie.Telemetry,
      Tomie.JobsListener,
      {Phoenix.PubSub, name: Tomie.PubSub},
      {Oban, oban_config()}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Tomie.Supervisor)
  end

  defp oban_config do
    opts = Application.get_env(:tomie, Oban)

    # Prevent running queues or scheduling jobs from an iex console.
    if Code.ensure_loaded?(IEx) and IEx.started?() do
      if System.get_env("QUEUE") == nil do
        opts
        |> Keyword.put(:crontab, false)
        |> Keyword.put(:queues, false)
      else
        opts
      end
    else
      opts
    end
  end
end
