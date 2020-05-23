defmodule TomieWeb.NoteLive.Index do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.NoteView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    notebooks = Notes.list_notebooks() |> Enum.with_index()
    selected = if Enum.count(notebooks) > 0, do: 0, else: -1

    {:ok, socket |> assign(
    	notebooks: notebooks, 
    	page_title: "Notes",
    	selected: selected
    )}
  end

  def handle_event("navigate", %{"key" => "ArrowRight"}, socket) do
  	socket = if in_bounds?(socket, socket.assigns.selected) do
  		{selected_notebook, _index} = 
	  		socket.assigns.notebooks
	  		|> Enum.find(fn {_notebook, index} -> 
	  			index == socket.assigns.selected
	  		end)

  		push_redirect(socket, to: Routes.live_path(socket, TomieWeb.NoteLive.ShowNotebook, selected_notebook))
  	else
  		socket
  	end

  	{:noreply, socket}
  end

  def handle_event("navigate", %{"key" => key}, socket) do
  	selected = case key do
  		"ArrowDown" ->
  			ensure_in_bounds(socket, socket.assigns.selected + 1)
  		"ArrowUp" ->
  			ensure_in_bounds(socket, socket.assigns.selected - 1)
  		_ -> 
  			socket.assigns.selected
  	end

  	{:noreply, socket |> assign(selected: selected)}
  end

  defp in_bounds?(socket, new_value) do
  	lower_bound = 0
  	upper_bound = Enum.count(socket.assigns.notebooks) - 1

  	cond do
  		new_value < lower_bound -> false
  		new_value > upper_bound -> false
  		true -> true
  	end
  end

  def ensure_in_bounds(socket, new_value) do
  	if in_bounds?(socket, new_value) do
  		new_value
  	else
  		socket.assigns.selected
  	end
  end
end
