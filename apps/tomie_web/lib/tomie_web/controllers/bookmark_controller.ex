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

  def visit(conn, %{"id" => id}) do
    {:ok, bookmark} = Bookmarks.visit_bookmark(id)

    conn
    |> redirect(external: bookmark.source)
  end
end
