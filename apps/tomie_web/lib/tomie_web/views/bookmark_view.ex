defmodule TomieWeb.BookmarkView do
  use TomieWeb, :view
  alias TomieWeb.BookmarkLive

  def domain(url) do
    url
    |> URI.parse()
    |> Map.get(:host)
  end
end
