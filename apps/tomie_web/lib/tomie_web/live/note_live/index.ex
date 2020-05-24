defmodule TomieWeb.NoteLive.Index do
  use TomieWeb, :live
  import TomieWeb.NoteLive.Navigation

  def render(assigns), do: TomieWeb.NoteView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    notebooks = Notes.list_notebooks() |> Enum.with_index()
    selected = -1

    {:ok,
     socket
     |> assign(
       notebooks: notebooks,
       page_title: "Notes",
       selected: selected
     )}
  end

  def handle_event("navigate", %{"key" => "ArrowRight"}, socket) do
    {:noreply, maybe_open_notebook(socket)}
  end

  def handle_event("navigate", %{"key" => "Enter"}, socket) do
    {:noreply, maybe_open_notebook(socket)}
  end

  def handle_event("navigate", %{"key" => key}, socket) do
    selected =
      case key do
        "ArrowDown" ->
          ensure_in_bounds(socket, socket.assigns.selected + 1, socket.assigns.notebooks)

        "ArrowUp" ->
          ensure_in_bounds(socket, socket.assigns.selected - 1, socket.assigns.notebooks)

        _ ->
          socket.assigns.selected
      end

    {:noreply, socket |> assign(selected: selected)}
  end

  defp maybe_open_notebook(socket) do
    if in_bounds?(socket.assigns.selected, socket.assigns.notebooks) do
      {selected_notebook, _index} =
        socket.assigns.notebooks
        |> Enum.find(fn {_notebook, index} ->
          index == socket.assigns.selected
        end)

      push_redirect(socket,
        to: Routes.live_path(socket, TomieWeb.NoteLive.ShowNotebook, selected_notebook)
      )
    else
      socket
    end
  end
end
