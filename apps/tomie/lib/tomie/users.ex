defmodule Users do
  def get_user!(id), do: Db.Repo.get!(Users.User, id)

  def update_profile(user, attrs \\ %{}) do
    user
    |> Users.User.profile_changeset(attrs)
    |> Db.Repo.update()
  end
end
