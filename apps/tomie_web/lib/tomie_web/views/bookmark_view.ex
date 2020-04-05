defmodule TomieWeb.BookmarkView do
  use TomieWeb, :view

  def tags(%{tags: []}), do: "None"
  def tags(%{tags: [tag]}), do: tag.name

  def tags(%{tags: tags}),
    do:
      tags
      |> Enum.map(&Map.get(&1, :name))
      |> Enum.join(",")
end
