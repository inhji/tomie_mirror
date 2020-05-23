defmodule TomieWeb.Pow do
  @moduledoc "Authentication helper functions"

  alias Tomie.Users.User
  alias Phoenix.LiveView.Socket
  alias Pow.Store.CredentialsCache

  @cache_backend Application.compile_env!(:tomie_web, [:pow, :cache_store_backend])

  @doc """
  Retrieves the currently-logged-in user from the Pow credentials cache.
  """
  @spec get_user(
          socket :: Socket.t(),
          session :: map(),
          config :: keyword()
        ) :: %User{} | nil

  def get_user(socket, session, config \\ [otp_app: :tomie_web])

  def get_user(socket, %{"tomie_web_auth" => signed_token}, config) do
    conn = struct!(Plug.Conn, secret_key_base: socket.endpoint.config(:secret_key_base))
    salt = Atom.to_string(Pow.Plug.Session)

    with {:ok, token} <- Pow.Plug.verify_token(conn, salt, signed_token, config),
         {user, _metadata} <-
           CredentialsCache.get([backend: Pow.Store.Backend.MnesiaCache], token) do
      user
    else
      _any -> nil
    end
  end

  def get_user(_, _, _), do: nil
end
