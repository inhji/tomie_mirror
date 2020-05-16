defmodule TomieWeb.NoteLive.Index do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.NoteView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    notebooks = Notes.list_notebooks()

    {:ok, socket |> assign(notebooks: notebooks, page_title: "Notes")}
  end
end
