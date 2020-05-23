defmodule TomieWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use TomieWeb, :controller
      use TomieWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: TomieWeb
      import Plug.Conn
      import TomieWeb.Gettext
      alias TomieWeb.Router.Helpers, as: Routes
    end
  end

  def live do
    quote do
      use Phoenix.LiveView, layout: {TomieWeb.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/tomie_web/templates",
        namespace: TomieWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Import external modules
      import PhoenixActiveLink

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router
      use Pow.Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import TomieWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import convenience functions for LiveView rendering
      import Phoenix.LiveView.Helpers

      import TomieWeb.ErrorHelpers
      import TomieWeb.Gettext

      import TomieWeb.Pow, only: [get_user: 2]

      alias TomieWeb.Router.Helpers, as: Routes
      alias TomieWeb.IconView
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
