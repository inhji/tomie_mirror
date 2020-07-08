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

  pipeline :home do
    plug :accepts, ["html"]
    plug TomieWeb.MenuPathPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  # --- Auth Routes

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  # --- Home Routes

  scope "/", TomieWeb do
    pipe_through :home

    get "/", HomeController, :index
    get "/about", HomeController, :about
    get "/menu", HomeController, :menu

    get "/project/:name", HomeController, :project
    get "/bookmark/:id", HomeController, :bookmark
  end

  # --- Admin Routes

  scope "/admin" do
    pipe_through [:browser, :protected]

    live_dashboard "/dashboard", metrics: Tomie.Telemetry
  end

  scope "/indie" do
    pipe_through [:api]

    forward "/micropub",
            PlugMicropub,
            handler: TomieWeb.MicropubHandler,
            json_encoder: Jason
  end

  scope "/admin", TomieWeb do
    pipe_through [:browser, :protected]

    live "/", PageLive.Index

    get "/posts", PostController, :index
    get "/posts/new", PostController, :new
    post "/posts/new", PostController, :create
    get "/posts/:id/edit", PostController, :edit
    post "/posts/:id/edit", PostController, :update
    put "/posts/:id/edit", PostController, :update
    put "/posts/:id/edit", PostController, :update
    delete "/posts/:id", PostController, :delete

    live "/bookmarks", BookmarkLive.Index
    live "/bookmarks/new", BookmarkLive.New
    live "/bookmarks/:id", BookmarkLive.Show
    live "/bookmarks/:id/edit", BookmarkLive.Edit

    live "/tags", TagLive.Index
    live "/tags/new", TagLive.New
    live "/tags/:id", TagLive.Show
    live "/tags/:id/edit", TagLive.Edit

    live "/jobs", JobLive.Index
    live "/jobs/queues", JobLive.Queues
    live "/jobs/:id", JobLive.Show

    live "/listens", ListenLive.Index
    live "/listens/artists", ListenLive.Artists
    live "/listens/albums", ListenLive.Albums
    live "/listens/charts", ListenLive.Charts
    live "/listens/artist/:id", ArtistLive.Show

    live "/listens/album/:id", AlbumLive.Show
    live "/listens/album/:id/edit", AlbumLive.Edit
    live "/listens/album/:id/merge", AlbumLive.Merge

    get "/r/:id/:slug", LinkController, :redirect

    resources "/profile", ProfileController,
      only: [:edit, :update, :show],
      singleton: true
  end
end
