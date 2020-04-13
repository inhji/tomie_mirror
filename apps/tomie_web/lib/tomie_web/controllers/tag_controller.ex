defmodule TomieWeb.TagController do
  use TomieWeb, :controller
  use Tags.Constants
  alias Tags.Tag

  def index(conn, _params) do
    tags = Tags.list_tags()

    render(conn, "index.html", tags: tags)
  end

  def index_json(conn, _params) do
    tags = Tags.list_tags()
    json(conn, tags)
  end

  def show(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)

    render(conn, "show.html", tag: tag)
  end

  def new(conn, _params) do
    changeset = Tag.changeset(%Tag{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tag" => tag_params}) do
    case Tags.create_tag(tag_params) do
      {:ok, _tag} ->
        conn
        |> put_flash(:info, @tag_created)
        |> redirect(to: Routes.tag_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)
    changeset = Tag.changeset(tag)

    render(conn, "edit.html", tag: tag, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Tags.get_tag!(id)

    case Tags.update_tag(tag, tag_params) do
      {:ok, _tag} ->
        conn
        |> put_flash(:info, @tag_updated)
        |> redirect(to: Routes.tag_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end
end
