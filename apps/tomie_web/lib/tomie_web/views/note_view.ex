defmodule TomieWeb.NoteView do
  use TomieWeb, :view
  alias TomieWeb.NoteLive

  def note_count(notebook) do
    Enum.count(notebook.notes) - 1
  end

  def active_class?(index, selected) do
    if index == selected do
      "active"
    else
      ""
    end
  end
end
