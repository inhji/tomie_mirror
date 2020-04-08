defmodule TomieWeb.LayoutView do
  use TomieWeb, :view

  def theme(conn) do
    user = Pow.Plug.current_user(conn)
    IO.inspect(user)

    case user do
      nil -> "light"
      user -> user.theme
    end
  end
end
