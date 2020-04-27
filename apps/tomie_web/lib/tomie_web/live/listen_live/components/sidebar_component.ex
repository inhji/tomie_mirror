defmodule TomieWeb.ListenLive.SidebarComponent do
  use TomieWeb, :live_component

  def render(assigns), do: TomieWeb.ListenView.render("sidebar.html", assigns)
end
