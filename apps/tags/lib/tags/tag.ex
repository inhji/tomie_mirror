defmodule Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tags.Slug

  schema "tags" do
    field :name, :string
    field :slug, Slug.Type

    timestamps()
  end

  def changeset(tag, attrs \\ %{}) do
    tag
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> Slug.maybe_generate_slug()
    |> Slug.unique_constraint()
  end
end
