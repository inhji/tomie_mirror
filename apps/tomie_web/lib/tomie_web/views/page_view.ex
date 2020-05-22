defmodule TomieWeb.PageView do
  use TomieWeb, :view

  def weather_icon_path(%{pretty: pretty} = weather) do
    Routes.static_path(TomieWeb.Endpoint, "/images/weather/#{pretty.icon}@2x.png")
  end
end
