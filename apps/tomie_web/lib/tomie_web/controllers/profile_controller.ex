defmodule TomieWeb.ProfileController do
  use TomieWeb, :controller

  defp sync_user(conn, user), do: Pow.Plug.create(conn, user)

  def show(conn, _params) do
    user = Pow.Plug.current_user(conn)
    render(conn, "show.html", user: user)
  end

  def edit(conn, _params) do
    user = Pow.Plug.current_user(conn)
    changeset = Users.User.profile_changeset(user)

    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"user" => user_params}) do
    user = Pow.Plug.current_user(conn)

    case Users.update_profile(user, user_params) do
      {:ok, user} ->
        conn
        |> sync_user(user)
        |> put_flash(:info, @tag_updated)
        |> redirect(to: Routes.profile_path(conn, :show))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end
end
