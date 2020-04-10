defmodule TomieWeb.BookmarkController do
  use TomieWeb, :controller
  use Bookmarks.Constants
  alias Bookmarks.Bookmark

  def index(conn, _params) do
    bookmarks = Bookmarks.list_bookmarks()

    render(conn, "index.html", bookmarks: bookmarks)
  end

  def new(conn, _params) do
    changeset = Bookmark.changeset(%Bookmark{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bookmark" => bookmark_params}) do
    case Bookmarks.create_bookmark(bookmark_params) do
      {:ok, bookmark} ->
        Worker.run(bookmark)

        conn
        |> put_flash(:info, @bookmark_created)
        |> redirect(to: Routes.bookmark_path(conn, :show, bookmark))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)
    render(conn, "show.html", bookmark: bookmark)
  end

  def edit(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)
    changeset = Bookmark.changeset(bookmark)

    render(conn, "edit.html", bookmark: bookmark, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bookmark" => bookmark_params}) do
    bookmark = Bookmarks.get_bookmark!(id)

    case Bookmarks.update_bookmark(bookmark, bookmark_params) do
      {:ok, _bookmark} ->
        conn
        |> put_flash(:info, @bookmark_updated)
        |> redirect(to: Routes.bookmark_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def visit(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)
    {:ok, _visited_bookmark} = Bookmarks.visit_bookmark(bookmark)

    conn
    |> redirect(external: bookmark.source)
  end

  def bookmarklet(conn, %{"url" => url, "token" => token}) do
    user = Pow.Plug.current_user(conn)

    if user.token == token do
      case Bookmarks.create_bookmark(%{source: url}) do
        {:ok, bookmark} ->
          Worker.run(bookmark)

          conn
          |> put_flash(:info, @bookmark_created)
          |> redirect(external: url)

        {:error, _changeset} ->
          conn
          |> put_flash(:error, "Could not create bookmark")
          |> render(PageView, "index.html")
      end
    else
      conn
      |> put_flash(:error, "Wrong token")
      |> render(PageView, "index.html")
    end
  end
end
