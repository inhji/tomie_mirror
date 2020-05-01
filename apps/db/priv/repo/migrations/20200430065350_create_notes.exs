defmodule Db.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notebooks) do
      add :title, :string
    end

    create table(:notes) do
      add :title, :string
      add :content, :text
      add :root, :boolean

      add :notebook_id, references(:notebooks)
    end

    create table(:note_paths) do
      add :depth, :integer
      add :ancestor, references(:notes)
      add :descendant, references(:notes)
    end
  end
end
