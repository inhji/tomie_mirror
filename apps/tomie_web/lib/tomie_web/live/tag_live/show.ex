defmodule TomieWeb.TagLive.Show do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.TagView.render("show.html", assigns)

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  def fetch(%{assigns: %{id: id}} = socket) do
    assign(socket, tag: Tags.get_tag!(id))
  end

  def handle_event("delete_tag", %{"id" => id}, socket) do
    Tags.get_tag!(id)
    |> Tags.delete_tag()

    {:noreply, push_redirect(socket, to: Routes.live_path(socket, TomieWeb.TagLive.Index))}
  end
end
