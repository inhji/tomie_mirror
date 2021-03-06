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
    tag = Tags.get_tag!(id)

    assigns = [
      tag: tag,
      tagged_bookmarks: Bookmarks.list_bookmarks_by_tag_id(id),
      page_title: tag.name
    ]

    assign(socket, assigns)
  end

  def handle_event("delete_tag", %{"id" => id}, socket) do
    Tags.get_tag!(id)
    |> Tags.delete_tag()

    {:noreply, push_redirect(socket, to: Routes.live_path(socket, TomieWeb.TagLive.Index))}
  end
end
