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

config :tomie_web,
  ecto_repos: [Db.Repo],
  generators: [context_app: :tomie]

# Configures the endpoint
config :tomie_web, TomieWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vA2gj8nBFMrN/nH0bjo09DfxDovTsbUZJbpnsawqXsTneL/F0nWEY5PfY5uptNra",
  render_errors: [view: TomieWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TomieWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "kRH3u6Gz"]

config :tomie_web, :pow,
  user: Tomie.Users.User,
  repo: Db.Repo,
  web_module: TomieWeb

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
