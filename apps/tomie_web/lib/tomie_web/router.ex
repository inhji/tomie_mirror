defmodule TomieWeb.Router do
  use TomieWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", TomieWeb do
    pipe_through [:browser, :protected]

    get "/", PageController, :index

    get "/bookmarks/:id/visit", BookmarkController, :visit
    get "/bookmarks/save", BookmarkController, :bookmarklet
    resources "/bookmarks", BookmarkController

    resources "/tags", TagController

    resources "/profile", ProfileController,
      only: [:show, :edit, :update],
      singleton: true
  end
end
