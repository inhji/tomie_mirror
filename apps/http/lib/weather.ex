defmodule Http.Weather do
  @base_url "http://api.openweathermap.org/data/2.5/onecall"
  @opts "units=metric,exclude=minutely,daily"

  def get_weather() do
    [api_key: api_key, latitude: lat, longitude: lon, city_id: _] =
      Application.fetch_env!(:http, :weather)

    url = "#{@base_url}?lat=#{lat}&lon=#{lon}&appid=#{api_key}&#{@opts}"

    with %{body: body, status_code: 200} <- Http.get!(url),
         {:ok, json} <- Jason.decode!(body, keys: :atoms) do
      json
    else
      error -> error
    end
  end

  def save_weather(%{
        current: current,
        daily: daily,
        hourly: _hourly,
        lat: _lat,
        lon: _lon,
        timezone: _timezone,
        timezone_offset: _timezone_offset
      }) do
    daily_data = Enum.map(daily, &map_daily/1)

    Cachex.put(:weather, :daily, daily_data)

    Cachex.put(:weather, :now, %{
      pretty: List.first(current.weather),
      temp: current.temp,
      clouds: current.clouds,
      timestamp: current.dt,
      humidity: current.humidity
    })
  end

  defp map_daily(day) do
    date =
      day.dt
      |> DateTime.from_unix!()
      |> DateTime.to_date()

    day
    |> Map.put(:date, date)
    |> Map.put(:pretty, List.first(day.weather))
  end
end
