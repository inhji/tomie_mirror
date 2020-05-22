defmodule Scraper.Workers.Weather do
  use Oban.Worker,
    queue: :scraper,
    max_attempts: 1,
    unique: [period: 60, fields: [:worker]]

  require Logger

  @impl Oban.Worker
  def perform(_args, _job) do
    weather = Scraper.Weather.get_weather()

    Cachex.put(:weather, :now, %{
      pretty: weather.weather |> List.first(),
      temp: weather.main,
      clouds: weather.clouds,
      location: weather.name,
      timestamp: weather.dt
    })
  end
end
