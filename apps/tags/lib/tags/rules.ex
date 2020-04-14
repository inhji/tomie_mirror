defmodule Tags.Rules do
  require Logger

  @doc """
  Parses autotagging-rules attached to Tags.

  ## Examples

  * title::contains::github.com
  * title::matches::github.com.+
  * content::matches::some content
  * source::contains::github.com

  """

  def parse(tags, entity) do
    tags
    |> Enum.map(&parse_tag(&1, entity))
    |> List.flatten()
    |> Enum.uniq()
  end

  def parse_tag(%{rules: rules, name: name}, entity) do
    rules
    |> String.split("\n")
    |> Enum.map(&parse_rule/1)
    |> Enum.reduce([], fn %{property: p, function: f, search_string: s}, tags ->
      atom_prop = String.to_existing_atom(p)
      property = Map.get(entity, atom_prop)

      # TODO: Refactor
      case f do
        "contains" -> rule_contains(tags, property, name, s)
        "matches" -> rule_matches(tags, property, name, s)
      end
    end)
  end

  def rule_contains(tags, property, name, search_string) do
    if property do
      if property |> String.downcase() |> String.contains?(search_string) do
        tags ++ [name]
      else
        tags
      end
    else
      Logger.warn("Rule for Tag<#{name}> contains unknown property [#{p}]!")
      tags
    end
  end

  def rule_matches(tags, property, name, search_string) do
    if Regex.compile!(search_string) |> Regex.match?(property),
      do: tags ++ [name],
      else: tags
  end

  def parse_rule(rule) do
    [property, function, search_string] = String.split(rule, "::")

    %{
      property: property,
      function: function,
      search_string: search_string
    }
  end
end
