defmodule Listens.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    import Cachex.Spec

    children = [
      worker(Cachex, [:listenbrainz, []], id: :listenbrainz)
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Listens.Supervisor)
  end
end
