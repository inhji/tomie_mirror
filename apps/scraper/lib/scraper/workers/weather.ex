defmodule Scraper.Workers.Weather do
  use Oban.Worker,
    queue: :scraper,
    max_attempts: 1,
    unique: [period: 60, fields: [:worker]]

  require Logger

  @impl Oban.Worker
  def perform(_args, _job) do
    weather_data = Scraper.Weather.get_weather()
    Scraper.Weather.save_weather(weather_data)
  end
end
