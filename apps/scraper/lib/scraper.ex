defmodule Scraper do
  @moduledoc """
  Documentation for `Scraper`.
  """

  def request_headers() do
    user_agent = Application.get_env(:tomie, :user_agent)

    [
      {"User-Agent", user_agent}
    ]
  end

  def get_html(url) do
    case HTTPoison.get(url, request_headers(), follow_redirect: true) do
      {:ok, %{body: body, status_code: 200}} ->
        {:ok, body}

      {:ok, status_code: status_code} ->
        {:error, status_code}

      {:error, error} ->
        {:error, error}
    end
  end

  def get_title!(html) do
    {:ok, document} = Floki.parse_document(html)

    document
    |> Floki.find("head title")
    |> Floki.text()
  end

  def parse(html) do
    title = get_title!(html)
    og = OpenGraphExtended.parse(html)
    result = Map.merge(%{title: title}, og, fn _k, v1, v2 -> v2 || v1 end)

    {:ok, result}
  end
end
