defmodule Bookmarks.Bookmark do
  use Ecto.Schema
  use Bookmarks.Constants
  import Ecto.Changeset

  defimpl String.Chars do
    def to_string(%{source: source}) do
      "Bookmark<#{source}>"
    end
  end

  @derive {Jason.Encoder, only: [:title, :source]}
  schema "posts" do
    field(:type, :string, default: @post_type)

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

  def changeset(bookmark, attrs \\ %{}) do
    bookmark
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
    |> maybe_set_content_html()
    |> validate_required([:source, :type])
  end

  defp maybe_set_content_html(changeset) do
    case get_change(changeset, :content) do
      nil -> changeset
      content -> maybe_render_markdown(changeset, content)
    end
  end

  defp maybe_render_markdown(changeset, content) do
    case Earmark.as_html(content, code_class_prefix: "language-") do
      {:ok, html, _} ->
        put_change(changeset, :content_html, html)

      {:error, _, errors} ->
        {_level, _line, message} = errors |> List.first()
        add_error(changeset, :content, "Error while rendering markdown: #{message}")
    end
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
