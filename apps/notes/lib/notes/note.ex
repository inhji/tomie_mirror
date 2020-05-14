defmodule Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :title, :string
    field :content, :string
    field :content_html, :string
    field :root, :boolean, default: false

    belongs_to :notebook, Notes.Book
  end

  def changeset(note, attrs \\ %{}) do
    note
    |> cast(attrs, [:title, :content, :notebook_id, :root])
    |> validate_required([:notebook_id])
    |> validate_required_content_or_title()
    |> maybe_set_content_html()
  end

  defp maybe_set_content_html(changeset) do
    case get_change(changeset, :content) do
      nil -> changeset
      content -> maybe_render_markdown(changeset, content)
    end
  end

  defp maybe_render_markdown(changeset, content) do
    opts = Application.fetch_env!(:earmark, :render_options)

    case Earmark.as_html(content, opts) do
      {:ok, html, _} ->
        put_change(changeset, :content_html, html)

      {:error, _, errors} ->
        {_level, _line, message} = errors |> List.first()
        add_error(changeset, :content, "Error while rendering markdown: #{message}")
    end
  end

  defp validate_required_content_or_title(changeset) do
    with title <- get_field(changeset, :title),
         content <- get_field(changeset, :content) do
      if is_nil(title) and is_nil(content) do
        changeset
        |> add_error(:title, "Either title or content is required!")
        |> add_error(:content, "Either title or content is required!")
      else
        changeset
      end
    end
  end
end
