defmodule TomieWeb.PageView do
  use TomieWeb, :view

  def weather_icon_path(%{pretty: pretty} = _weather) do
    Routes.static_path(TomieWeb.Endpoint, "/images/weather/#{pretty.icon}@2x.png")
  end

  def to_celsius(kelvin) do
    Float.round(kelvin - 273.15, 1)
  end

  def forecast_days(forecast) do
    forecast
    |> Enum.drop(1)
    |> Enum.take(3)
  end

  def weekday(timestamp) do
    timestamp
    |> Timex.from_unix()
    |> Timex.to_date()
    |> Timex.format!("{WDshort}")
  end
end
