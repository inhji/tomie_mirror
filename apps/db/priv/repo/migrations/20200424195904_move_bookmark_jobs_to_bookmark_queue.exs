defmodule Db.Repo.Migrations.MoveBookmarkJobsToBookmarkQueue do
  use Ecto.Migration

  def change do
    execute(&execute_up/0, &execute_down/0)
  end

  def execute_up do
    sql = """
      UPDATE oban_jobs
      SET queue = 'bookmarks'
      WHERE worker = 'Bookmarks.Worker'
    """

    repo().query!(sql)
  end

  def execute_down do
    sql = """
      UPDATE oban_jobs
      SET queue = 'default'
      WHERE worker = 'Bookmarks.Worker'
    """

    repo().query!(sql)
  end
end
