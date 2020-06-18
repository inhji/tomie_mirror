defmodule TomieWeb.PageLive.Index do
  use TomieWeb, :live
  alias TomieWeb.PageView

  def render(assigns), do: PageView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    weather = Cachex.get!(:weather, :now)
    {:ok, socket |> assign(weather: weather, page_title: "Dashboard")}
  end
end
