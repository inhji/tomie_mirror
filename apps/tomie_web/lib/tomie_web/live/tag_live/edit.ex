defmodule TomieWeb.TagLive.Edit do
  use TomieWeb, :live
  alias Tags.Tag
  alias TomieWeb.{TagLive, TagView}

  def render(assigns), do: TagView.render("edit.html", assigns)
  def mount(_params, _session, socket), do: {:ok, socket}

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  def fetch(%{assigns: %{id: id}} = socket) do
    tag = Tags.get_tag!(id)
    assign(socket, tag: tag, changeset: Tag.changeset(tag), page_title: "Edit #{tag.name}")
  end

  def handle_event("save", %{"tag" => params}, socket) do
    case Tags.update_tag(socket.assigns.tag, params) do
      {:ok, tag} ->
        {:noreply, push_redirect(socket, to: Routes.live_path(socket, TagLive.Show, tag))}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
