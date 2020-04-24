defmodule TomieWeb.JobLive.SidebarComponent do
  use TomieWeb, :live_component

  def render(assigns), do: TomieWeb.JobView.render("sidebar.html", assigns)
end
