defmodule Listens.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Cachex, [:listenbrainz, []], id: :listenbrainz),
      worker(Cachex, [:discogs, []], id: :discogs),
      {Phoenix.PubSub, name: Listens.PubSub}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Listens.Supervisor)
  end
end
