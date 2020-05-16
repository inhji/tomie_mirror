defmodule TomieWeb.TagLive.New do
  use TomieWeb, :live
  alias Tags.Tag

  def render(assigns), do: TomieWeb.TagView.render("new.html", assigns)

  def mount(_params, _session, socket) do
    changeset = Tag.changeset(%Tag{})
    {:ok, socket |> assign(changeset: changeset, page_title: "New Tag")}
  end

  def handle_event("validate", %{"tag" => params}, socket) do
    changeset =
      %Tag{}
      |> Tag.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"tag" => params}, socket) do
    case Tags.create_tag(params) do
      {:ok, tag} ->
        {:noreply,
         push_redirect(socket, to: Routes.live_path(socket, TomieWeb.TagLive.Show, tag))}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
