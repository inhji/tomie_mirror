defmodule Tomie.Jobs do
  import Ecto.Query, warn: false

  def list_jobs() do
    Db.Repo.all(list_jobs_query())
  end

  def list_jobs_by_queue(queue) when queue in ["bookmarks", "listens"] do
    Db.Repo.all(
      from list_jobs_query(),
        where: [queue: ^queue]
    )
  end

  def list_jobs_by_state(state) when state in ["completed", "discarded", "retryable"] do
    Db.Repo.all(
      from list_jobs_query(),
        where: [state: ^state]
    )
  end

  defp list_jobs_query() do
    from j in Oban.Job,
      order_by: [desc: j.inserted_at],
      limit: 20
  end

  def get_job!(id), do: Db.Repo.get!(Oban.Job, id)

  def delete_job(id) do
    job = get_job!(id)
    Db.Repo.delete(job)
  end
end
