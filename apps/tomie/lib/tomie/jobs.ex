defmodule Tomie.Jobs do
  import Ecto.Query, warn: false

  def list_jobs() do
    Db.Repo.all(
      from j in Oban.Job,
        order_by: [desc: j.completed_at]
    )
  end

  def get_job!(id), do: Db.Repo.get!(Oban.Job, id)

  def delete_job(id) do
    job = get_job!(id)
    Db.Repo.delete(job)
  end
end
