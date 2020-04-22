defmodule Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tags.Slug

  @derive {Jason.Encoder, only: [:name]}
  schema "tags" do
    field :name, :string
    field :slug, Slug.Type
    field :rules, :string

    timestamps()
  end

  def changeset(tag \\ %Tags.Tag{}, attrs \\ %{}) do
    tag
    |> cast(attrs, [:name, :slug, :rules])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> add_default_rule()
    |> Slug.maybe_generate_slug()
    |> Slug.unique_constraint()
  end

  def add_default_rule(changeset) do
    case get_change(changeset, :rules) do
      nil -> put_change(changeset, :rules, do_add_default_rule(changeset))
      _rules -> changeset
    end
  end

  def do_add_default_rule(changeset) do
    case get_change(changeset, :name) do
      nil -> get_field(changeset, :rules, nil)
      name -> "title::contains::#{name}"
    end
  end
end
