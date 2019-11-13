use Mix.Config

# Configure your database
config :sw_store, SwStore.Repo,
  username: "postgres",
  password: "postgres",
  database: "sw_store_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sw_store, SwStoreWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
