defmodule TomieWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use TomieWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      alias TomieWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint TomieWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Db.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Db.Repo, {:shared, self()})
    end

    conn =
      if tags[:logged_in] do
        conn = Phoenix.ConnTest.build_conn()

        user = %Users.User{
          id: 1,
          email: "test@example.com",
          token: "token"
        }

        conn
        |> Pow.Plug.put_config([])
        |> Pow.Plug.assign_current_user(user, [])
      else
        Phoenix.ConnTest.build_conn()
      end

    {:ok, conn: conn}
  end
end
