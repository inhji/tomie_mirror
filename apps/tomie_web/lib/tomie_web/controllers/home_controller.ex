defmodule TomieWeb.HomeController do
  use TomieWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout("home.html")
    |> render("index.html")
  end
end
