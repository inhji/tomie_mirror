defmodule RulesTest do
  use ExUnit.Case

  test "parse/2 returns a list of tags from a set of rules and an entity" do
    entity = %{title: "A cool project on github"}
    tags = [%{name: "github", rules: "title::contains::github\ntitle::contains::project"}]

    assert ["github"] = Tags.Rules.parse(entity, tags)
  end

  test "parse_tag/2 correctly parses a contains rule" do
    entity = %{title: "A cool project on github"}
    tag = %{name: "github", rules: "title::contains::github"}

    assert ["github"] = Tags.Rules.parse_tag(entity, tag)
  end

  test "parse_tag/2 correctly parses a matches rule" do
    entity = %{title: "A cool project on github", source: "https://github.com/inhji/akedia"}
    tag = %{name: "github", rules: "source::matches::.+github.com.+"}

    assert ["github"] = Tags.Rules.parse_tag(entity, tag)
  end

  test "parse_rule/1 parses a rule" do
    assert %{property: "title", function: "contains", search_string: "github"} =
             Tags.Rules.parse_rule("title::contains::github")
  end
end
