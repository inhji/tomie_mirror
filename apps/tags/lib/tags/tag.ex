defmodule Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tags.{Tag, Slug}

  @attrs [:name, :slug, :rules]

  @derive {Jason.Encoder, only: [:name]}
  schema "tags" do
    field :name, :string
    field :slug, Slug.Type
    field :rules, :string

    timestamps()
  end

  def changeset(tag \\ %Tag{}, attrs \\ %{}) do
    tag
    |> cast(attrs, @attrs)
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> Slug.maybe_generate_slug()
    |> Slug.unique_constraint()
  end

  def insert_changeset(tag \\ %Tag{}, attrs \\ %{}) do
    changeset(tag, attrs)
    |> add_default_rule()
  end

  def add_default_rule(changeset) do
    case get_change(changeset, :rules) do
      nil ->
        name = get_change(changeset, :name)
        put_change(changeset, :rules, "title::contains::#{name}")

      _ ->
        changeset
    end
  end
end
