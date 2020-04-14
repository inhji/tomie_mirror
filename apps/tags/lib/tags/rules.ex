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
    |> Enum.reduce([], fn %{property: p, function: f, argument: a}, tags ->
      property = String.to_existing_atom(p)
      value = Map.get(entity, property)

      if rule_match?(f, value, a),
        do: tags ++ [name],
        else: tags
    end)
  end

  def rule_match?(_, nil, _), do: false

  def rule_match?("contains", value, argument) do
    value
    |> String.downcase()
    |> String.contains?(argument)
  end

  def rule_match?("matches", value, argument) do
    argument
    |> Regex.compile!()
    |> Regex.match?(value)
  end

  def rule_match(_, _, _), do: false

  def parse_rule(rule) do
    [property, function, argument] = String.split(rule, "::")

    %{
      property: property,
      function: function,
      argument: argument
    }
  end
end
