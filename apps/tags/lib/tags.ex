defmodule Tags do
  @moduledoc """
  Documentation for `Tags`.
  """

  def add(%{id: id}, join_module, tag) when is_binary(tag) do
    {:ok, tag} = create_or_get_tag(tag)

    struct(join_module)
    |> join_module.changeset(%{post_id: id, tag_id: tag.id})
    |> Repo.insert()
  end

  def create_tag(name) do
    %Tags.Tag{}
    |> Tags.Tag.changeset(%{name: name})
    |> Db.Repo.insert()
  end

  def list_tags() do
    Tags.Tag
    |> Db.Repo.all()
  end

  def create_or_get_tag(tag) do
    case get_tag_by_slug(Slugger.slugify_downcase(tag)) do
      nil -> create_tag(tag)
      tag -> {:ok, tag}
    end
  end

  def get_tag_by_slug!(slug), do: Db.Repo.get_by!(Tags.Tag, slug: slug)

  def get_tag_by_slug(slug), do: Db.Repo.get_by(Tags.Tag, slug: slug)

  def add_tag_relation(entity_id, topic_id) do
  end
end
