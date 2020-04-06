defmodule TomieWeb.TagController do
  use TomieWeb, :controller
  use Tags.Constants
  alias Tags.Tag

  def index(conn, _params) do
    tags = Tags.list_tags()

    render(conn, "index.html", tags: tags)
  end

  def new(conn, _params) do
    changeset = Tag.changeset(%Tag{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tag" => tag_params}) do
    case Tags.create_tag(tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, @tag_created)
        |> redirect(to: Routes.tag_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
