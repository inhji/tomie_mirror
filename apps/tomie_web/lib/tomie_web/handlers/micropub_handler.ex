defmodule TomieWeb.MicropubHandler do
  @behaviour PlugMicropub.HandlerBehaviour
  use TomieWeb, :handler
  require Logger

  import Indie.Micropub

  @impl true
  def handle_create(_type, properties, access_token) do
    Logger.info("plug_micropub/handle_create")

    own_hostname =
      TomieWeb.Endpoint
      |> TomieWeb.Router.Helpers.url()
      |> URI.parse()
      |> Map.get(:host)

    with :ok <- Indie.Token.verify(access_token, "create", own_hostname),
         {:ok, post_type} <- Indie.Micropub.get_post_type(properties) do
      create_post(post_type, properties)
    end
  end

  def create_post(:bookmark, props) do
    attrs = %{
      title: get_title(props),
      content: get_content(props),
      source: get_bookmarked_url(props)
    }

    Logger.info("plug_micropub/create_post/bookmark")
    Logger.debug(inspect(attrs))

    case Bookmarks.create_bookmark(attrs) do
      {:ok, bookmark} ->
        TomieWeb.BookmarkWorker.new(%{
          id: bookmark.id,
          url: Routes.home_url(TomieWeb.Endpoint, :bookmark, bookmark)
        })
        |> Oban.insert()

        {:ok, :created, Routes.home_url(TomieWeb.Endpoint, :bookmark, bookmark)}

      {:error, error} ->
        Logger.error(error)
        {:error, :internal_server_error}
    end
  end
end
