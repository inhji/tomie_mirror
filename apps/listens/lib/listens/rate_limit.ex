defmodule Listens.RateLimit do
  def calculate(headers, :listenbrainz) do
    keyword_list = convert_to_keyword_list(headers)

    %{
      total: Keyword.get(keyword_list, :"X-RateLimit-Limit"),
      remaining: Keyword.get(keyword_list, :"X-RateLimit-Remaining")
    }
  end

  def calculate(headers, :discogs) do
    keyword_list = convert_to_keyword_list(headers)

    %{
      total: Keyword.get(keyword_list, :"X-Discogs-Ratelimit"),
      remaining: Keyword.get(keyword_list, :"X-Discogs-Ratelimit-Remaining")
    }
  end

  defp convert_to_keyword_list(list) do
    Enum.map(list, fn {name, value} ->
      {String.to_atom(name), value}
    end)
  end
end
