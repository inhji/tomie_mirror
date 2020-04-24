defmodule Tomie.Jobs do
  import Ecto.Query, warn: false

  def list_jobs() do
    Db.Repo.all(list_jobs_query())
  end

  def list_jobs(:successful) do
    Db.Repo.all(
      from list_jobs_query(),
        where: [state: "completed"]
    )
  end

  def list_jobs(:failed) do
    Db.Repo.all(
      from list_jobs_query(),
        where: [state: "discarded"]
    )
  end

  def list_jobs(:retrying) do
    Db.Repo.all(
      from list_jobs_query(),
        where: [state: "retryable"]
    )
  end

  defp list_jobs_query() do
    from j in Oban.Job,
      order_by: [desc: j.completed_at],
      limit: 50
  end

  def get_job!(id), do: Db.Repo.get!(Oban.Job, id)

  def delete_job(id) do
    job = get_job!(id)
    Db.Repo.delete(job)
  end
end
