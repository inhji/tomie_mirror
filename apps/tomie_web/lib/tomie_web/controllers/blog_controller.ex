defmodule TomieWeb.PostController do
  use TomieWeb, :controller

  def index(conn, _params) do
    posts = Blog.list_posts()

    render(conn, "index.html", posts: posts)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.Post.changeset(post)

    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    case Blog.update_post(post, post_params) do
      {:ok, _post} ->
        conn
        |> redirect(to: Routes.post_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def new(conn, _params) do
    changeset = Blog.Post.changeset(%Blog.Post{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Blog.create_post(post_params) do
      {:ok, _post} ->
        conn
        |> redirect(to: Routes.post_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted!")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
