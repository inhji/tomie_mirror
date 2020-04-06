defmodule Tags.Rules do
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

      case f do
        "contains" ->
          if String.contains?(property, s),
            do: tags ++ [name],
            else: tags

        "matches" ->
          if Regex.compile!(s) |> Regex.match?(property),
            do: tags ++ [name],
            else: tags
      end
    end)
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
