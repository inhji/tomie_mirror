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
    |> validate_required([:content, :notebook_id])
  end
end
