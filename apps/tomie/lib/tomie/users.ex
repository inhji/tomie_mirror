defmodule Tomie.Users do
  def get_user!(id), do: Db.Repo.get!(Tomie.Users.User, id)

  def update_profile(user, attrs \\ %{}) do
    user
    |> Tomie.Users.User.profile_changeset(attrs)
    |> Db.Repo.update()
  end
end
