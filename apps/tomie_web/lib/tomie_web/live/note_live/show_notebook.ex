defmodule TomieWeb.NoteLive.ShowNotebook do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.NoteView.render("show_notebook.html", assigns)

  def mount(%{"id" => id}, _session, socket) do
    {notebook, nodes} = Notes.get_notebook!(id, depth: 1)

    {:ok, socket |> assign(notebook: notebook, nodes: nodes)}
  end
end
