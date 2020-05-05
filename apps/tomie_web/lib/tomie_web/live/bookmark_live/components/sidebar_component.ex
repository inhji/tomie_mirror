defmodule TomieWeb.BookmarkLive.SidebarComponent do
  use TomieWeb, :live_component

  def render(assigns), do: TomieWeb.BookmarkView.render("sidebar.html", assigns)
end
