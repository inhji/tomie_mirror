defmodule TomieWeb.NoteView do
  use TomieWeb, :view
  alias TomieWeb.NoteLive

  def note_count(notebook) do
    Enum.count(notebook.notes) - 1
  end

  def active_class?(socket) when is_map(socket) do
    if socket.assigns.active do
      "active"
    else
      ""
    end
  end

  def active_class?(active) do
    if active do
      "active"
    else
      ""
    end
  end
end
