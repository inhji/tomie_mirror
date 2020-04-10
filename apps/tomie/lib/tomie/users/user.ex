defmodule Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    pow_user_fields()

    field :theme, :string, default: "light"
    field :token, :string
    field :reset_token, :boolean, virtual: true

    timestamps()
  end

  def profile_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:theme, :token, :reset_token])
    |> validate_inclusion(:theme, ["dark", "light"])
    |> maybe_reset_token()
  end

  defp maybe_reset_token(changeset) do
    case get_change(changeset, :reset_token, false) do
      true -> put_change(changeset, :token, token(20))
      false -> changeset
    end
  end

  defp token(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64()
    |> binary_part(0, length)
  end
end
