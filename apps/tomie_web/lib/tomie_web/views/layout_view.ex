defmodule TomieWeb.LayoutView do
  use TomieWeb, :view

  def theme(conn) do
    case Pow.Plug.current_user(conn) do
      nil -> "light"
      user -> user.theme
    end
  end
end
