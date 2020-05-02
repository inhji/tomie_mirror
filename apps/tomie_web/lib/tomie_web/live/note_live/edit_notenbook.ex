defmodule TomieWeb.NoteLive.EditNotebook do
  use TomieWeb, :live
  alias Notes.Book

  def render(assigns), do: TomieWeb.NoteView.render("edit_notebook.html", assigns)

  def mount(%{"id" => id}, _session, socket) do
    {notebook, _tree} = Notes.get_notebook!(id, nodes: false)
    changeset = Book.changeset(notebook, %{})
    {:ok, socket |> assign(changeset: changeset, notebook: notebook)}
  end

  def handle_event("validate", %{"book" => params}, socket) do
    changeset =
      %Book{}
      |> Book.changeset(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"book" => params}, socket) do
    IO.inspect(socket)

    case Notes.update_notebook(socket.assigns.notebook, params) do
      {:ok, notebook} ->
        {:noreply,
         push_redirect(socket,
           to:
             Routes.live_path(
               socket,
               TomieWeb.NoteLive.ShowNotebook,
               notebook
             )
         )}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
