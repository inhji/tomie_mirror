# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :db,
  ecto_repos: [Db.Repo]

config :tomie,
  user_agent: "Tomie/0.x +https://inhji.de"

config :listens,
  discogs_token: "kRIDCYTMRucJojWzQKlXlDAnDlQSgmXboMEZiUBT"

config :scraper, :weather,
  api_key: "5e8d6569a828fd7860acf87bf1113a9e",
  city_id: "2920512"

config :indie,
  token_endpoint: "https://tokens.indieauth.com/token",
  auth_endpoint: "https://indieauth.com/auth",
  supported_scopes: [
    # Micropub scopes
    "create",
    "update",
    "delete",
    "undelete",
    "media",
    # Microsub scopes
    "read",
    "follow",
    "mute",
    "block",
    "channels"
  ]

config :tomie, Oban,
  repo: Db.Repo,
  prune: {:maxlen, 10_000},
  queues: [bookmarks: 10, listens: 10, scraper: 10],
  crontab: [
    {"* * * * *", Listens.Workers.Listenbrainz, args: %{user: "inhji"}},
    {"* * * * *", Listens.Workers.DiscogsArtist, args: %{}},
    {"* * * * *", Listens.Workers.DiscogsAlbum, args: %{action: "search_id"}},
    {"* * * * *", Listens.Workers.DiscogsAlbum, args: %{action: "fetch_cover"}},
    {"* * * * *", Listens.Workers.DiscogsAlbum, args: %{action: "fetch_genres"}},
    {"*/5 * * * *", Scraper.Workers.Weather, args: %{}}
  ]

config :tomie_web,
  ecto_repos: [Db.Repo],
  generators: [context_app: :tomie]

# Configures the endpoint
config :tomie_web, TomieWeb.Endpoint,
  url: (System.get_env("TUNNEL") && [host: "tunnel.inhji.de", port: 443, scheme: "https"]) || nil,
  secret_key_base: "vA2gj8nBFMrN/nH0bjo09DfxDovTsbUZJbpnsawqXsTneL/F0nWEY5PfY5uptNra",
  render_errors: [view: TomieWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: TomieWeb.PubSub,
  live_view: [signing_salt: "La8TeKsJi1aZt2Bhp8vXfx9HOOFpP/JY"]

config :tomie_web, :pow,
  user: Tomie.Users.User,
  repo: Db.Repo,
  web_module: TomieWeb,
  cache_store_backend: Pow.Store.Backend.MnesiaCache

config :mnesia, dir: 'cache'

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :chartkick, json_serializer: Jason

config :earmark,
  render_options: [code_class_prefix: "language-"]

config :waffle,
  storage: Waffle.Storage.Local,
  storage_dir_prefix: "uploads"

config :git_ops,
  mix_project: Tomie.Umbrella.MixProject,
  changelog_file: "CHANGELOG.md",
  repository_url: "https://git.inhji.de/inhji/tomie",
  types: [
    # Makes an allowed commit type called `tidbit` that is not
    # shown in the changelog
    tidbit: [
      hidden?: true
    ],
    # Makes an allowed commit type called `important` that gets
    # a section in the changelog with the header "Important Changes"
    important: [header: "Important Changes"],
    tweak: [header: "Tweaks"],
    ref: [header: "Refactors"]
  ],
  # Instructs the tool to manage your mix version in your `mix.exs` file
  # See below for more information
  manage_mix_version?: true,
  # Instructs the tool to manage the version in your README.md
  # Pass in `true` to use `"README.md"` or a string to customize
  manage_readme_version: "README.md",
  version_tag_prefix: "v"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
