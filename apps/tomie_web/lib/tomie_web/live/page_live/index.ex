defmodule TomieWeb.PageLive.Index do
  use TomieWeb, :live
  alias TomieWeb.PageView

  def render(assigns), do: PageView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    weather = Cachex.get!(:weather, :now)
    forecast = Cachex.get!(:weather, :daily)
    {:ok, socket |> assign(weather: weather, forecast: forecast, page_title: "Dashboard")}
  end
end
