defmodule TomieWeb.BookmarkView do
  use TomieWeb, :view
  alias TomieWeb.BookmarkLive

  def domain(url) do
    url
    |> URI.parse()
    |> Map.get(:host)
  end

  def favorite_action(%{is_favorite: true}), do: "Unfavorite"
  def favorite_action(%{is_favorite: _}), do: "Favorite"

  def archive_action(%{is_archived: true}), do: "Unarchive"
  def archive_action(%{is_archived: _}), do: "Archive"
end
