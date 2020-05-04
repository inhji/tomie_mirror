defmodule Db.Repo.Migrations.AddContentHtmlToNotes do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add :content_html, :text
    end
  end
end
