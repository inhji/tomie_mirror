defmodule TagsTest do
  use ExUnit.Case
  doctest Tags
  alias Tags.Tag

  @name "Foo Bar"
  @name2 "Bar Baz"
  @expected_slug "foo-bar"

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Db.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Db.Repo, {:shared, self()})
    end

    :ok
  end

  test "create_tag/1 creates a new tag" do
    {:ok, tag} = Tags.create_tag(@name)
    assert tag.name == @name
    assert tag.slug == @expected_slug
  end

  test "get_tag_by_slug!/1 gets a tag by its slug" do
    {:ok, tag} = Tags.create_tag(@name)
    new_tag = Tags.get_tag_by_slug!(tag.slug)
    assert new_tag.name == tag.name
  end

  test "get_tag_by_slug/1 gets a tag by its slug" do
    {:ok, tag} = Tags.create_tag(@name)
    new_tag = Tags.get_tag_by_slug(tag.slug)
    assert new_tag.name == tag.name
  end

  test "list_tags/0 lists all tags" do
    {:ok, _first_tag} = Tags.create_tag(@name)
    {:ok, _second_tag} = Tags.create_tag(@name2)

    assert [%Tag{}, %Tag{}] = Tags.list_tags()
  end

  test "create_or_get_tag/1 creates an new tag" do
    {:ok, tag} = Tags.create_or_get_tag(@name)
    assert tag.name == @name
  end

  test "create_or_get_tag/1 returns an existing tag" do
    {:ok, tag} = Tags.create_tag("Foo bar")
    {:ok, existing_tag} = Tags.create_or_get_tag("Foo bar")
    assert tag.name == existing_tag.name
  end
end
