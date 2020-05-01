defmodule Notes do
  @moduledoc """
  Documentation for `Notes`.
  """

  import Ecto.Query, warn: false
  alias Notes.{Book, Note, Tree}

  def get_note!(id) do
    Db.Repo.get!(Note, id)
  end

  def get_rootnode!(notebook_id) do
    Note
    |> where([n], n.root == true)
    |> where([n], n.notebook_id == ^notebook_id)
    |> Db.Repo.one!()
  end

  def create_note(parent, attrs \\ %{}) do
    {:ok, note} =
      attrs
      |> Map.put_new(:notebook_id, parent.notebook_id)
      |> do_create_note()

    Tree.insert(note.id, parent.id)
  end

  defp do_create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Db.Repo.insert()
  end

  def list_notebooks() do
    Book
    |> Db.Repo.all()
    |> Db.Repo.preload([:notes])
  end

  def get_notebook!(id, tree_opts \\ []) do
    notebook = Db.Repo.get!(Book, id)
    root_note = Db.Repo.get_by!(Note, notebook_id: notebook.id, root: true)
    {:ok, tree} = Tree.descendants(root_note.id, [nodes: true] ++ tree_opts)

    {notebook, tree}
  end

  def create_notebook(attrs \\ %{}) do
    with {:ok, notebook} <- do_create_notebook(attrs),
         {:ok, root_note} <-
           do_create_note(%{
             notebook_id: notebook.id,
             content: "ROOT",
             title: "ROOT",
             root: true
           }),
         {:ok, _tree} <- Tree.insert(root_note.id, root_note.id) do
      {:ok, notebook}
    else
      error -> error
    end
  end

  defp do_create_notebook(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Db.Repo.insert()
  end
end
