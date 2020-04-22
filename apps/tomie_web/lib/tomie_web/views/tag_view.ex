defmodule TomieWeb.TagView do
  use TomieWeb, :view
  alias TomieWeb.TagLive

  def rule_count(tag) do
    case tag.rules do
      nil ->
        0

      rules ->
        rules
        |> String.split("\n")
        |> Enum.count()
    end
  end

  def rules(tag) do
    case tag.rules do
      nil -> []
      rules -> rules |> String.split("\n")
    end
  end
end
