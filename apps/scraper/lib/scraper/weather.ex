defmodule Scraper.Weather do
  def get_weather() do
    [api_key: api_key, latitude: lat, longitude: lon, city_id: _] =
      Application.fetch_env!(:scraper, :weather)

    base_url = "http://api.openweathermap.org/data/2.5/onecall"
    url = "#{base_url}?lat=#{lat}&lon=#{lon}&appid=#{api_key}&units=metric,exclude=minutely,daily"

    with %{body: body, status_code: 200} <- Http.get!(url),
         {:ok, json} <- Jason.decode!(body, keys: :atoms) do
      json
    else
      error -> error
    end
  end
end
