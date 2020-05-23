defmodule Scraper.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Cachex, [:weather, []], id: :weather)
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Scraper.Supervisor)
  end
end
