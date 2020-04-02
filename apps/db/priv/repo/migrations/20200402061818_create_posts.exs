defmodule Db.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :text
      add :source, :string

      timestamps()
    end

    create index(:posts, [:title])
    create index(:posts, [:content])
  end
end
