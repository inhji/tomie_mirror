defmodule TomieWeb.NoteLive.NoteComponent do
  use TomieWeb, :live_component

  def mount(socket), do: {:ok, socket}

  def render(assigns), do: TomieWeb.NoteView.render("note_component.html", assigns)

  def update(%{note: note, active: active}, socket) do
    {:ok, socket |> assign(note: note, children: fetch(note), active: active)}
  end

  def update(%{note: note}, socket) do
    {:ok, socket |> assign(note: note, children: fetch(note), active: false)}
  end

  def fetch(note) do
    {:ok, children} = Notes.Tree.descendants(note.id, nodes: true, depth: 1)
    children
  end
end
