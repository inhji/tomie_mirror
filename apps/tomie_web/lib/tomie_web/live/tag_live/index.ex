defmodule TomieWeb.TagLive.Index do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.TagView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    tags =
      Tags.list_tags()
      |> Enum.map(fn tag ->
        {tag, Bookmarks.count_bookmarks_by_tag_id(tag.id)}
      end)

    {:ok, socket |> assign(tags: tags, page_title: "Tags")}
  end
end
