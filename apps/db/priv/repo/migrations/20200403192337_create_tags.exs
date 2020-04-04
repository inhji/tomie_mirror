defmodule Db.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :slug, :string

      timestamps()
    end

    create unique_index(:tags, [:name])
    create unique_index(:tags, [:slug])
  end
end
