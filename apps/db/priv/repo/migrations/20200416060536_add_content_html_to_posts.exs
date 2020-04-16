defmodule Db.Repo.Migrations.AddContentHtmlToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :content_html, :text
    end
  end
end
