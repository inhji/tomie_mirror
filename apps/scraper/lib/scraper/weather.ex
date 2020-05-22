defmodule Scraper.Weather do
  def get_weather() do
    [api_key: api_key, city_id: city_id] = Application.fetch_env!(:scraper, :weather)
    base_url = "http://api.openweathermap.org/data/2.5/weather"
    url = "#{base_url}?id=#{city_id}&appid=#{api_key}&units=metric"

    with %{body: body, status_code: 200} <- Http.get!(url),
         {:ok, json} <- Jason.decode!(body, keys: :atoms) do
      json
    else
      error -> error
    end
  end
end
