defmodule TomieWeb.NoteLive.NoteComponent do
  use TomieWeb, :live_component

  def render(assigns), do: TomieWeb.NoteView.render("note.html", assigns)

  def update(%{note: note}, socket) do
    {:ok, children} = Notes.Tree.descendants(note.id, nodes: true, depth: 1)
    {:ok, socket |> assign(note: note, children: children)}
  end
end
