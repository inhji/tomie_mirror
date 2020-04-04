defmodule Db.Repo.Migrations.CreatePostsTags do
  use Ecto.Migration

  def change do
    create table(:posts_tags) do
      add :post_id, :integer
      add :tag_id, :integer

      timestamps()
    end

    create index(:posts_tags, [:post_id])
    create index(:posts_tags, [:tag_id])
    create unique_index(:posts_tags, [:post_id, :tag_id])
  end
end
