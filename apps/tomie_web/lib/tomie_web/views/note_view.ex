defmodule TomieWeb.NoteView do
  use TomieWeb, :view
  alias TomieWeb.NoteLive

  def note_count(notebook) do
    Enum.count(notebook.notes) - 1
  end
end
