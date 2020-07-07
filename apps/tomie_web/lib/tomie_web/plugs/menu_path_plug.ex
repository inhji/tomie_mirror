defmodule TomieWeb.MenuPathPlug do
  import Plug.Conn, only: [assign: 3]
  alias TomieWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(%{request_path: path, req_headers: headers} = conn, _opts) do
    menu_path =
      if path === Routes.home_path(conn, :menu) do
        get_referrer_path(headers)
      else
        Routes.home_path(conn, :menu)
      end

    assign(conn, :menu_path, menu_path)
  end

  defp get_referrer_path(headers) do
    headers
    |> Enum.into(%{})
    |> Map.get("referer")
    |> URI.parse()
    |> Map.get(:path)
  end
end
