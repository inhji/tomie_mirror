defmodule Bookmarks.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub.PG2, name: Bookmarks.PubSub}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Bookmarks.Supervisor)
  end
end
