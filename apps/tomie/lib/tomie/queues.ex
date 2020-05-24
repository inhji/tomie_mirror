defmodule Tomie.Queues do
  import Ecto.Query, warn: false

  def list_queues do
    query =
      from j in Oban.Job,
        group_by: [j.state, j.queue],
        select: %{
          state: j.state,
          queue: j.queue,
          jobs: count(j.queue)
        }

    Db.Repo.all(query)
    |> Enum.group_by(&Map.get(&1, :queue))
  end
end
