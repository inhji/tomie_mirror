defmodule Blog do
  @moduledoc """
  Documentation for `Blog`.
  """

  import Ecto.Query, warn: false
  alias Blog.Post

  @preloads [:tags]

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Db.Repo.insert()
  end

  def update_post(post, attrs) do
    post
    |> Db.Repo.preload(@preloads)
    |> Post.changeset(attrs)
    |> Db.Repo.update()
  end

  def get_post!(id),
    do:
      Db.Repo.get!(Post, id)
      |> Db.Repo.preload(@preloads)

  def list_posts(limit \\ 10) do
    Post
    |> where(type: "post")
    |> limit(^limit)
    |> order_by([p], desc: p.inserted_at)
    |> Db.Repo.all()
    |> Db.Repo.preload(@preloads)
  end

  def list_notes(limit \\ 10) do
    Post
    |> where(type: "post")
    |> where([p], is_nil(p.title))
    |> limit(^limit)
    |> order_by([p], desc: p.inserted_at)
    |> Db.Repo.all()
    |> Db.Repo.preload(@preloads)
  end

  def list_articles(limit \\ 10) do
    Post
    |> where(type: "post")
    |> where([p], not is_nil(p.title))
    |> limit(^limit)
    |> order_by([p], desc: p.inserted_at)
    |> Db.Repo.all()
    |> Db.Repo.preload(@preloads)
  end

  def delete_post(post) do
    Db.Repo.delete(post)
  end
end
