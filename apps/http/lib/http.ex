defmodule Http do
  @moduledoc """
  Documentation for `Http`.
  """

  use HTTPoison.Base
  @user_agent Application.compile_env!(:tomie, :user_agent)
  @options [ssl: [{:versions, [:"tlsv1.2", :"tlsv1.1", :tlsv1]}]]
  @headers [
    {"User-Agent", @user_agent}
  ]

  def process_request_headers(headers), do: headers ++ @headers
  def process_request_options(options), do: options ++ @options
end
