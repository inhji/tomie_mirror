defmodule Tomie.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    pow_user_fields()

    field :name, :string
    field :username, :string
    field :tagline, :string

    field :theme, :string, default: "light"
    field :token, :string
    field :reset_token, :boolean, virtual: true

    field :avatar, Tomie.Users.Uploader.Type

    timestamps()
  end

  def profile_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:theme, :token, :reset_token, :name, :username, :tagline])
    |> cast_attachments(attrs, [:avatar])
    |> validate_inclusion(:theme, ["dark", "light-purple", "light-red"])
    |> maybe_create_token()
    |> maybe_reset_token()
  end

  def avatar(user, version \\ :large) do
    Tomie.Users.Uploader.url({:avatar, user}, version)
  end

  defp maybe_reset_token(changeset) do
    case get_change(changeset, :reset_token, false) do
      true -> put_change(changeset, :token, token(20))
      false -> changeset
    end
  end

  defp maybe_create_token(changeset) do
    case get_field(changeset, :token, nil) do
      nil -> put_change(changeset, :token, token(20))
      _token -> changeset
    end
  end

  defp token(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64()
    |> binary_part(0, length)
  end
end
