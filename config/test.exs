use Mix.Config

# Configure your database
config :db, Db.Repo,
  username: "postgres",
  password: "postgres",
  database: "tomie_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tomie_web, TomieWeb.Endpoint,
  http: [port: 4002],
  server: false

config :tomie_web,
  disable_workers: true

# Print only warnings and errors during test
config :logger, level: :warn
