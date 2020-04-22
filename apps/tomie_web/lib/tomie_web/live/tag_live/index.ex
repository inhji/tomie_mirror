defmodule TomieWeb.TagLive.Index do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.TagView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    tags = Tags.list_tags()

    {:ok, socket |> assign(tags: tags)}
  end
end
