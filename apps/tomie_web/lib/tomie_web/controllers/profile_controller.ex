defmodule TomieWeb.ProfileController do
  use TomieWeb, :controller

  defp sync_user(conn, user), do: Pow.Plug.create(conn, user)

  def show(conn, %{"id" => id}) do
    render(conn, "show.html")
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.User.profile_changeset(user)

    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    case Users.update_profile(user, user_params) do
      {:ok, user} ->
        conn
        |> sync_user(user)
        |> put_flash(:info, @tag_updated)
        |> redirect(to: Routes.profile_path(conn, :show, user))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end
end
