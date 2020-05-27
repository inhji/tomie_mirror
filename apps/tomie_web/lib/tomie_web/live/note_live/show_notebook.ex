defmodule TomieWeb.NoteLive.ShowNotebook do
  use TomieWeb, :live
  import TomieWeb.NoteLive.Navigation

  def render(assigns), do: TomieWeb.NoteView.render("show_notebook.html", assigns)

  def mount(%{"id" => id}, _session, socket) do
    {notebook, nodes, root} = Notes.get_notebook!(id, depth: 1)

    {:ok,
     socket
     |> assign(
       notebook: notebook,
       nodes: nodes |> Enum.with_index(),
       root: root,
       page_title: notebook.title,
       selected: -1
     )}
  end

  def handle_event("delete_notebook", %{"id" => id}, socket) do
    {notebook, _, _} = Notes.get_notebook!(id, nodes: false)
    Notes.delete_notebook(notebook)

    {:noreply, push_redirect(socket, to: Routes.live_path(socket, TomieWeb.NoteLive.Index))}
  end

  def handle_event("navigate", %{"key" => "ArrowRight"}, socket) do
    {:noreply, maybe_open_note(socket)}
  end

  def handle_event("navigate", %{"key" => "Enter"}, socket) do
    {:noreply, maybe_open_note(socket)}
  end

  def handle_event("navigate", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, TomieWeb.NoteLive.Index))}
  end

  def handle_event("navigate", %{"key" => key}, socket) do
    selected =
      case key do
        "ArrowDown" ->
          ensure_in_bounds(socket, socket.assigns.selected + 1, socket.assigns.nodes)

        "ArrowUp" ->
          ensure_in_bounds(socket, socket.assigns.selected - 1, socket.assigns.nodes)

        _ ->
          socket.assigns.selected
      end

    {:noreply, socket |> assign(selected: selected)}
  end

  defp maybe_open_note(socket) do
    if in_bounds?(socket.assigns.selected, socket.assigns.nodes) do
      {selected_note, _index} =
        socket.assigns.nodes
        |> Enum.find(fn {_node, index} ->
          index == socket.assigns.selected
        end)

      push_redirect(socket,
        to:
          Routes.live_path(
            socket,
            TomieWeb.NoteLive.ShowNote,
            socket.assigns.notebook,
            selected_note
          )
      )
    else
      socket
    end
  end
end
