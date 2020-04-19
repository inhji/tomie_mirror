defmodule TomieWeb.BookmarkView do
  use TomieWeb, :view
  alias TomieWeb.BookmarkLive

  def domain(url) do
    url
    |> URI.parse()
    |> Map.get(:host)
  end

  def favorite_action(bookmark) do
    if bookmark.is_favorite do
      "Unfavorite"
    else
      "Favorite"
    end
  end
end
