defmodule Db.Repo.Migrations.AddNameToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string, default: "Inhji"
      add :username, :string, default: "inhji"
    end
  end
end
