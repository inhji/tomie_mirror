defmodule TomieWeb.BookmarkController do
  use TomieWeb, :controller
  use Bookmarks.Constants
  alias Bookmarks.Bookmark

  plug :check_token when :action in [:bookmarklet]

  def check_token(%{params: %{"token" => token}} = conn, _params) do
    user = Pow.Plug.current_user(conn)

    if user.token == token do
      conn
    else
      conn
      |> put_flash(:error, "Wrong token")
      |> render(PageView, "index.html")
    end
  end

  def index(conn, _params) do
    bookmarks = Bookmarks.list_bookmarks()

    render(conn, "index.html", bookmarks: bookmarks)
  end

  def index_json(conn, _params) do
    bookmarks = Bookmarks.list_bookmarks()
    json(conn, bookmarks)
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

    render(conn, "edit.html",
      bookmark: bookmark,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "bookmark" => %{"tag_string" => tags} = bookmark_params}) do
    bookmark = Bookmarks.get_bookmark!(id)

    case Bookmarks.update_bookmark(bookmark, bookmark_params) do
      {:ok, bookmark} ->
        Bookmarks.update_tags(tags, bookmark)

        conn
        |> put_flash(:info, @bookmark_updated)
        |> redirect(to: Routes.bookmark_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)

    case Bookmarks.delete_bookmark(bookmark) do
      {:ok, _bookmark} ->
        conn
        |> put_flash(:info, @bookmark_deleted)
        |> redirect(to: Routes.bookmark_path(conn, :index))

      {:error, _changeset} ->
        render(conn, "show.html", bookmark: bookmark)
    end
  end

  def visit(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)
    {:ok, _visited_bookmark} = Bookmarks.visit_bookmark(bookmark)

    conn
    |> redirect(external: bookmark.source)
  end

  def bookmarklet(conn, %{"url" => url, "content" => content, "name" => name} = params) do
    changeset =
      Bookmark.changeset(%Bookmark{}, %{
        source: url,
        description: content,
        title: name
      })

    render(conn, "new.html", changeset: changeset)
  end
end
