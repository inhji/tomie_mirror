defmodule Http do
  @moduledoc """
  Documentation for `Http`.
  """

  use HTTPoison.Base

  @headers [
    {"User-Agent", "Tomie/0.x +https://dev.inhji.de"}
  ]

  @options [ssl: [{:versions, [:"tlsv1.2", :"tlsv1.1", :tlsv1]}]]

  def process_request_headers(headers), do: headers ++ @headers
  def process_request_options(options), do: options ++ @options
end
