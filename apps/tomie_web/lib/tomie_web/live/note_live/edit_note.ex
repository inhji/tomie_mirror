defmodule TomieWeb.NoteLive.EditNote do
  use TomieWeb, :live
  alias Notes.Note

  def render(assigns), do: TomieWeb.NoteView.render("edit_note.html", assigns)

  def mount(%{"id" => id, "note_id" => note_id}, _session, socket) do
    note = Notes.get_note!(note_id)
    changeset = Note.changeset(note, %{})

    note = Notes.get_note!(note_id)
    {:ok, socket |> assign(changeset: changeset, note: note, notebook_id: id)}
  end

  def handle_event("validate", %{"note" => params}, socket) do
    changeset =
      %Note{}
      |> Note.changeset(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"note" => params}, socket) do
    case Notes.update_note(socket.assigns.note, params) do
      {:ok, note} ->
        {:noreply,
         push_redirect(socket,
           to:
             Routes.live_path(
               socket,
               TomieWeb.NoteLive.ShowNote,
               socket.assigns.notebook_id,
               note
             )
         )}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
