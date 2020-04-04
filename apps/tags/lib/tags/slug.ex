defmodule Tags.Slug do
  use EctoAutoslugField.Slug, from: :name, to: :slug

  def build_slug(sources, changeset) do
    sources
    |> super(changeset)
    |> String.downcase()
  end
end
