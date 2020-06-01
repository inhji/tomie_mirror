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

  scope "/", TomieWeb do
    get "/", HomeController, :index
  end

  scope "/admin" do
    pipe_through [:browser, :protected]

    live_dashboard "/dashboard", metrics: Tomie.Telemetry
  end

  scope "/admin", TomieWeb do
    pipe_through [:browser, :protected]

    live "/", PageLive.Index

    live "/bookmarks", BookmarkLive.Index
    live "/bookmarks/new", BookmarkLive.New
    live "/bookmarks/:id", BookmarkLive.Show
    live "/bookmarks/:id/edit", BookmarkLive.Edit

    live "/notebooks", NoteLive.Index
    live "/notebooks/new", NoteLive.NewNotebook
    live "/notebooks/:id", NoteLive.ShowNotebook
    live "/notebooks/:id/edit", NoteLive.EditNotebook

    live "/notebooks/:id/note/new", NoteLive.NewNote
    live "/notebooks/:id/note/:note_id", NoteLive.ShowNote
    live "/notebooks/:id/note/:note_id/edit", NoteLive.EditNote

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

    live "/profile", ProfileLive.Show

    get "/r/:id/:slug", LinkController, :redirect

    resources "/profile", ProfileController,
      only: [:edit, :update],
      singleton: true
  end
end
