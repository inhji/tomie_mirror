defmodule Db.Repo.Migrations.RemoveNotes do
  use Ecto.Migration

  def change do
  	drop table(:note_paths)
  	drop table(:notes)
  	drop table(:notebooks)
  end
end
