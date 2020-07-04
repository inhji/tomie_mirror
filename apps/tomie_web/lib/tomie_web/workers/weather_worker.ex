defmodule TomieWeb.WeatherWorker do
	use Oban.Worker,
    queue: :scraper,
    max_attempts: 1,
    unique: [period: 60, fields: [:worker]]

  @impl Oban.Worker
  def perform(_args, _job) do
    Http.Weather.get_weather()
    |> Http.Weather.save_weather()
  end
end