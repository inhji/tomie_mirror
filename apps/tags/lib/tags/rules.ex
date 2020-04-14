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
        "contains" -> rule_contains(property, tags, name, s)
        "matches" -> rule_matches(property, tags, name, s)
      end
    end)
  end

  def rule_contains(nil, tags, _, _), do: tags

  def rule_contains(property, tags, name, search_string) do
    contains_search_string? = property
      |> String.downcase()
      |> String.contains?(search_string)
      
    if contains_search_string?, 
      do: tags ++ [name],
      else: tags
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
