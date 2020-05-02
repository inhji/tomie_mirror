defmodule TomieWeb.NoteLive.ShowNotebook do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.NoteView.render("show_notebook.html", assigns)

  def mount(%{"id" => id}, _session, socket) do
    {notebook, nodes, root} = Notes.get_notebook!(id, depth: 1)

    {:ok, socket |> assign(notebook: notebook, nodes: nodes, root: root)}
  end

  def handle_event("delete_notebook", %{"id" => id}, socket) do
    {notebook, _, _} = Notes.get_notebook!(id, nodes: false)
    Notes.delete_notebook(notebook)

    {:noreply, push_redirect(socket, to: Routes.live_path(socket, TomieWeb.NoteLive.Index))}
  end
end
