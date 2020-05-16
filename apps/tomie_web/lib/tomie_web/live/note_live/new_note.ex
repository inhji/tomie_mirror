defmodule TomieWeb.NoteLive.NewNote do
  use TomieWeb, :live
  alias Notes.Note
  alias TomieWeb.NoteLive

  def render(assigns), do: TomieWeb.NoteView.render("new_note.html", assigns)

  def mount(%{"id" => _id, "parent" => parent_id}, _session, socket) do
    parent = Notes.get_note!(parent_id)
    changeset = Note.changeset(%Note{})
    {:ok, assign(socket, changeset: changeset, parent: parent, page_title: "New Note")}
  end

  def handle_event("validate", %{"note" => params}, socket) do
    changeset =
      %Note{}
      |> Note.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"note" => params}, socket) do
    case Notes.create_note(socket.assigns.parent, params) do
      {:ok, note} ->
        path = Routes.live_path(socket, NoteLive.ShowNotebook, note.notebook_id)
        {:noreply, push_redirect(socket, to: path)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
