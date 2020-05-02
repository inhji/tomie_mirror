defmodule Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :title, :string
    field :content, :string
    field :root, :boolean, default: false

    belongs_to :notebook, Notes.Book
  end

  def changeset(note, attrs \\ %{}) do
    note
    |> cast(attrs, [:title, :content, :notebook_id, :root])
    |> validate_required([:notebook_id])
    |> validate_required_content_or_title()
  end

  defp validate_required_content_or_title(changeset) do
    with title <- get_field(changeset, :title),
         content <- get_field(changeset, :content) do
      IO.inspect(title)
      IO.inspect(content)

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
