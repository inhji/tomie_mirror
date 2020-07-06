defmodule TomieWeb.HomeController do
  use TomieWeb, :controller

  plug :with_home_layout
  plug :with_indie_endpoints

  @token_endpoint Application.compile_env!(:indie, :token_endpoint)
  @auth_endpoint Application.compile_env!(:indie, :auth_endpoint)
  @micropub_endpoint "/indie/micropub"

  def index(conn, _params) do
    bookmarks = Bookmarks.list_bookmarks("", "recent", 3)
    posts = Blog.list_posts(3)
    listens = Listens.Listens.list_listens(3)
    user = Tomie.Users.get_user!(1)

    conn
    |> render("index.html",
      bookmarks: bookmarks,
      posts: posts,
      listens: listens,
      page_title: "Home",
      user: user
    )
  end

  def about(conn, _params) do
    render(conn, "about.html", page_title: "About")
  end

  def project(conn, %{"name" => name}) do
    pretty_name = String.capitalize(name)

    render(conn, "project_#{name}.html", page_title: pretty_name)
  end

  def bookmark(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)
    page_title = bookmark.title || bookmark.source

    render(conn, "bookmark.html", bookmark: bookmark, page_title: page_title)
  end

  defp with_home_layout(conn, _opts), do: put_layout(conn, "home.html")

  defp with_indie_endpoints(conn, _opts) do
    conn
    |> assign(:token_endpoint, @token_endpoint)
    |> assign(:auth_endpoint, @auth_endpoint)
    |> assign(:micropub_endpoint, @micropub_endpoint)
  end
end
