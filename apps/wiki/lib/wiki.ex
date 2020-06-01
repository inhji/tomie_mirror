defmodule Wiki do
  @moduledoc """
  Documentation for `Wiki`.
  """

  import Ecto.Query, warn: false
  alias Wiki.Page

  @preloads [:tags]

  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Db.Repo.insert()
  end

  def update_page(page, attrs) do
    page
    |> Db.Repo.preload(@preloads)
    |> Page.changeset(attrs)
    |> Db.Repo.update()
  end

  def get_page!(id),
    do:
      Db.Repo.get!(Page, id)
      |> Db.Repo.preload(@preloads)

  def list_pages() do
    %Page{}
    |> Db.Repo.all()
    |> Db.Repo.preload(@preloads)
  end

  def delete_page(page) do
    Db.Repo.delete(page)
  end
end
