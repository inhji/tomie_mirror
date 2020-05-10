defmodule Tags do
  @moduledoc """
  Documentation for `Tags`.
  """

  import Ecto.Query, warn: false
  alias Tags.Tag

  def create_tag(name) when is_binary(name) do
    create_tag(%{name: name})
  end

  def create_tag(attrs) when is_map(attrs) do
    %Tag{}
    |> Tag.insert_changeset(attrs)
    |> Db.Repo.insert()
  end

  def update_tag(tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Db.Repo.update()
  end

  def delete_tag(tag) do
    Db.Repo.delete(tag)
  end

  def list_tags() do
    Tags.Tag
    |> order_by(:name)
    |> Db.Repo.all()
  end

  def list_tags_with_rules() do
    Tags.Tag
    |> where([t], not is_nil(t.rules))
    |> Db.Repo.all()
  end

  def create_or_get_tag(tag) do
    case get_tag_by_slug(Slugger.slugify_downcase(tag)) do
      nil -> create_tag(tag)
      tag -> {:ok, tag}
    end
  end

  def get_tag!(id), do: Db.Repo.get!(Tag, id)

  def get_tag_by_slug!(slug), do: Db.Repo.get_by!(Tag, slug: slug)

  def get_tag_by_slug(slug), do: Db.Repo.get_by(Tag, slug: slug)

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
  def update_tags_for_entity(tags, %{id: _id} = entity) when is_list(tags) do
    new_tags =
      tags
      |> Enum.filter(fn tag -> String.length(tag) > 0 end)
      |> Enum.uniq()
      |> Enum.map(&Tags.create_or_get_tag(&1))
      |> Enum.reduce([], fn {:ok, tag}, tag_list -> [tag | tag_list] end)

    entity
    |> entity.__struct__.changeset(%{})
    |> Ecto.Changeset.put_assoc(:tags, new_tags)
    |> Db.Repo.update()
  end

  def from_string(tags) when is_binary(tags) do
    tags
    |> String.trim()
    |> String.trim(",")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
  end
end
