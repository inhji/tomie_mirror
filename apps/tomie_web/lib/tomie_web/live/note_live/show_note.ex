defmodule TomieWeb.NoteLive.ShowNote do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.NoteView.render("show_note.html", assigns)

  def mount(%{"id" => id, "note_id" => note_id}, _session, socket) do
    note = Notes.get_note!(note_id)
    {:ok, socket |> assign(note: note, notebook_id: id)}
  end

  def handle_params(%{"id" => _id, "note_id" => note_id}, _url, socket) do
    note = Notes.get_note!(note_id)
    {:noreply, socket |> assign(note: note)}
  end
end
