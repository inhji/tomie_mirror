defmodule Db.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :type, :string

      add :title, :string
      add :content, :text
      add :source, :string

      add :is_favorite, :boolean
      add :is_archived, :boolean
      add :is_published, :boolean

      add :viewed_at, :naive_datetime
      add :views, :integer

      timestamps()
    end

    create index(:posts, [:title])
    create index(:posts, [:content])
  end
end
