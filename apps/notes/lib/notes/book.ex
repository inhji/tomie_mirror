defmodule Notes.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notebooks" do
    field :title, :string

    has_many :notes, Notes.Note, foreign_key: :notebook_id
  end

  def changeset(book, attrs \\ %{}) do
    book
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
