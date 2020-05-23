defmodule TomieWeb.ProfileLive.Show do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ProfileView.render("show.html", assigns)

  def mount(_params, session, socket) do
    {:ok, socket |> assign(user: get_user(socket, session), page_title: "Profile")}
  end
end
