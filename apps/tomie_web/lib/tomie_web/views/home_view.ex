defmodule TomieWeb.HomeView do
  use TomieWeb, :view

  def tag_string(tags) do
    case tags do
      [] ->
        "No Tags"

      _ ->
        tags
        |> Enum.map(fn t -> t.name end)
        |> Enum.join(", ")
    end
  end
end
