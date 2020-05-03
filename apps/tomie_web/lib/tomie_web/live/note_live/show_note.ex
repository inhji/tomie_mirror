defmodule TomieWeb.NoteLive.ShowNote do
  use TomieWeb, :live
  alias TomieWeb.NoteView
  alias TomieWeb.NoteLive

  def render(assigns), do: NoteView.render("show_note.html", assigns)

  def mount(%{"id" => id, "note_id" => note_id}, _session, socket) do
    note = Notes.get_note!(note_id)
    {:ok, socket |> assign(note: note, notebook_id: id)}
  end

  def handle_params(%{"id" => _id, "note_id" => note_id}, _url, socket) do
    note = Notes.get_note!(note_id)
    {:noreply, socket |> assign(note: note)}
  end

  def handle_event("delete_note", %{"id" => id}, socket) do
    {:ok, _note} =
      id
      |> Notes.get_note!()
      |> Notes.delete_note()

    {:noreply,
     push_redirect(socket,
       to: Routes.live_path(socket, NoteLive.ShowNotebook, socket.assigns.notebook_id)
     )}
  end
end
