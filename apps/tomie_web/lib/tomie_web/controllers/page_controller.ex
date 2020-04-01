defmodule TomieWeb.PageController do
  use TomieWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
