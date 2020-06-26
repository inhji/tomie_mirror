defmodule Scraper.Workers.Weather do
  use Oban.Worker,
    queue: :scraper,
    max_attempts: 1,
    unique: [period: 60, fields: [:worker]]

  require Logger

  @impl Oban.Worker
  def perform(_args, _job) do
    %{
      current: current,
      daily: _daily,
      hourly: _hourly,
      lat: _lat,
      lon: _lon,
      timezone: _timezone,
      timezone_offset: _timezone_offset
    } = Scraper.Weather.get_weather()

    Cachex.put(:weather, :now, %{
      pretty: current.weather |> List.first(),
      temp: Float.round(current.temp - 273.15, 1),
      clouds: current.clouds,
      timestamp: current.dt,
      humidity: current.humidity
    })
  end
end
