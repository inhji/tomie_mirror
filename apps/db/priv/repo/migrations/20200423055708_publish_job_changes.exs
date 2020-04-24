defmodule Db.Repo.Migrations.PublishJobChanges do
  use Ecto.Migration

  def change do
    execute(&execute_up/0, &execute_down/0)
  end

  defp execute_up do
    create_function = """
      CREATE OR REPLACE FUNCTION notify_job_changes()
      RETURNS trigger AS $$
      BEGIN
      PERFORM pg_notify(
        'jobs_changed',
        json_build_object(
          'operation', TG_OP,
          'record', NEW.id
        )::text
      );

      RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;
    """

    create_trigger = """
      CREATE TRIGGER jobs_changed
      AFTER INSERT OR UPDATE
      ON oban_jobs
      FOR EACH ROW
      EXECUTE PROCEDURE notify_job_changes()
    """

    repo().query!(create_function)
    repo().query!(create_trigger)
  end

  def execute_down do
    repo().query!("DROP TRIGGER IF EXISTS jobs_changed ON oban_jobs")
    repo().query!("DROP FUNCTION IF EXISTS notify_job_changes")
  end
end
