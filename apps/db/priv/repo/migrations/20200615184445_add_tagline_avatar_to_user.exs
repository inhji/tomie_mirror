defmodule Db.Repo.Migrations.AddTaglineAvatarToUser do
  use Ecto.Migration

  def change do
  	alter table(:users) do
  	  add :avatar, :string
  	  add :tagline, :string
  	end
  end
end
