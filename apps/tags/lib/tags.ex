defmodule Tags do
  @moduledoc """
  Documentation for `Tags`.
  """

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

  @doc """
  Updates tags for a given entity

  The entity is expected
  * to be a ecto struct
  * to have a many-to-many relation to tags
  * to exist in the `posts` table

  The many-to-many relation should be configured like so:

    many_to_many :tags, Tags.Tag,
      join_through: "posts_tags",
      join_keys: [post_id: :id, tag_id: :id],
      on_replace: :delete,
      unique: true

  """
  def update_tags_for_entity(%{id: _id} = entity, tags) when is_list(tags) do
    new_tags =
      tags
      |> Enum.map(&Tags.create_or_get_tag(&1))
      |> Enum.reduce([], fn {:ok, tag}, tag_list -> [tag | tag_list] end)

    entity
    |> entity.__struct__.changeset(%{})
    |> Ecto.Changeset.put_assoc(:tags, new_tags)
    |> Db.Repo.update()
  end
end
