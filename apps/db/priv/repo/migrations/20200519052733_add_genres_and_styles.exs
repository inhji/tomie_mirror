defmodule Db.Repo.Migrations.AddGenresAndStyles do
  use Ecto.Migration

  def change do
    alter table(:albums) do
      add :styles, {:array, :string}
      add :genres, {:array, :string}
    end
  end
end
