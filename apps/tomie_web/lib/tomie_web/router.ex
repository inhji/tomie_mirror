defmodule TomieWeb.Router do
  use TomieWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {TomieWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/" do
    pipe_through [:browser, :protected]

    live_dashboard "/dashboard", metrics: TomieWeb.Telemetry
  end

  scope "/", TomieWeb do
    pipe_through [:browser, :protected]

    live "/", PageLive.Index

    live "/bookmarks", BookmarkLive.Index
    live "/bookmarks/new", BookmarkLive.New
    live "/bookmarks/:id", BookmarkLive.Show
    live "/bookmarks/:id/edit", BookmarkLive.Edit

    get "/r/:id/:slug", LinkController, :redirect

    resources "/tags", TagController

    resources "/profile", ProfileController,
      only: [:show, :edit, :update],
      singleton: true
  end
end
