defmodule TomieWeb.NoteLive.NewNotebook do
  use TomieWeb, :live
  alias Notes.Book

  def render(assigns), do: TomieWeb.NoteView.render("new_notebook.html", assigns)

  def mount(_params, _session, socket) do
    changeset = Book.changeset(%Book{})
    {:ok, assign(socket, changeset: changeset, page_title: "New Notebook")}
  end

  def handle_event("validate", %{"book" => params}, socket) do
    changeset =
      %Book{}
      |> Book.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"book" => params}, socket) do
    case Notes.create_notebook(params) do
      {:ok, notebook} ->
        {:noreply,
         push_redirect(socket,
           to: Routes.live_path(socket, TomieWeb.NoteLive.ShowNotebook, notebook)
         )}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
