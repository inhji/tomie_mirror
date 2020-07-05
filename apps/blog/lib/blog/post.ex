defmodule Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :type, :string, default: "post"

    field :source, :string
    field :title, :string
    field :content, :string
    field :content_html, :string

    field :views, :integer, default: 0
    field :viewed_at, :naive_datetime

    field :is_favorite, :boolean, default: false
    field :is_published, :boolean, default: false
    field :is_archived, :boolean, default: false

    many_to_many :tags, Tags.Tag,
      join_through: "posts_tags",
      join_keys: [post_id: :id, tag_id: :id],
      on_replace: :delete,
      unique: true

    field :tag_string, :string, virtual: true, default: ""

    timestamps()
  end

  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [
      :source,
      :title,
      :content,
      :views,
      :viewed_at,
      :is_favorite,
      :is_published,
      :is_archived
    ])
    |> maybe_set_tag_string()
    |> validate_required([:source, :type])
  end

  # This function requires tags to be preloaded!
  # See Bookmarks.update_bookmark/2 or Bookmarks.visit_bookmark/1
  defp maybe_set_tag_string(changeset) do
    case get_field(changeset, :tags) do
      nil ->
        changeset

      tags ->
        put_change(changeset, :tag_string, Enum.map_join(tags, ", ", fn tag -> tag.name end))
    end
  end
end
