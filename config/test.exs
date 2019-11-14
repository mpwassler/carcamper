use Mix.Config

# Configure your database
config :sw_store, SwStore.Repo,
  username: System.get_env("PGUSER"),
  password: System.get_env("PGPASSWORD"),
  database: System.get_env("PGDATABASE") <> "-test",
  hostname: System.get_env("PGHOST"),
  port: System.get_env("PGPORT"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sw_store, SwStoreWeb.Endpoint,
  http: [port: 4001],  
  server: true
config :sw_store, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn
