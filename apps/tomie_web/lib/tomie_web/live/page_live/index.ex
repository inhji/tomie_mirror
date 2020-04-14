defmodule TomieWeb.PageLive.Index do
  use TomieWeb, :live
  alias TomieWeb.PageView

  def render(assigns), do: PageView.render("index.html", assigns)
end
