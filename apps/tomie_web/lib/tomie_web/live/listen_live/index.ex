defmodule TomieWeb.ListenLive.Index do
  use TomieWeb, :live

  def render(assigns), do: TomieWeb.ListenView.render("index.html", assigns)

  def mount(_args, _session, socket) do
    listens = Listens.Listens.list_listens()

    {:ok, socket |> assign(listens: listens)}
  end
end
