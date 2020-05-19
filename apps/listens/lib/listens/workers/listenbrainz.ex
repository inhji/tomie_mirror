defmodule Listens.Workers.Listenbrainz do
  use Oban.Worker,
    queue: :listens,
    max_attempts: 3,
    unique: [period: 60, fields: [:worker]]

  require Logger

  alias Listens.Workers.Listenbrainz.Handler

  @base_url "https://api.listenbrainz.org/1/user"
  @cache :listenbrainz
  @default_listen_count 10

  @last_listen_timestamp "last_listen_timestamp"
  @fetch_listen_count "fetch_listen_count"
  @rate_limit "rate_limit"

  @impl Oban.Worker
  def perform(%{"user" => user}, _job) do
    count = Listens.Cache.try_get(@cache, @fetch_listen_count, @default_listen_count)
    last_ts = Handler.last_listen_timestamp()
    url = "#{@base_url}/#{user}/listens?min_ts=#{last_ts}&count=#{count}"

    Logger.info("Fetching new Listens for Timestamp #{last_ts}:")
    Logger.info(url)

    case Http.get!(url) do
      %HTTPoison.Response{body: body, headers: headers} ->
        newest_timestamp =
          body
          |> Jason.decode!(keys: :atoms)
          |> Map.get(:payload)
          |> Map.get(:listens)
          |> Handler.handle_fetch_response(last_ts)

        rate_limit = Listens.RateLimit.calculate(headers, :listenbrainz)

        Listens.Cache.try_put(@cache, @last_listen_timestamp, newest_timestamp)
        Listens.Cache.try_put(@cache, @rate_limit, rate_limit)

      error ->
        Logger.error(inspect(error))
    end

    Listens.Cache.try_put(@cache, "updated_at", DateTime.utc_now())

    Phoenix.PubSub.broadcast(TomieWeb.PubSub, "Listens.Workers:ALL", %{
      event: :updated
    })

    :ok
  end
end
