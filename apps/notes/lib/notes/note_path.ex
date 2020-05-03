defmodule Notes.NotePath do
  use Ecto.Schema

  @primary_key false

  schema "note_paths" do
    field :depth, :integer, default: 0
    belongs_to :parent_note, Notes.Note, foreign_key: :ancestor
    belongs_to :note, Notes.Note, foreign_key: :descendant
  end
end
