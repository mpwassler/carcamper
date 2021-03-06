# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sw_store,
  ecto_repos: [SwStore.Repo]

# Configures the endpoint
config :sw_store, SwStoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "P1I19OAoBgVe4+fZC1RXlT63M4Rxjri8B3Oin0lmQkkJWrlHimVTpcVyQItazgze",
  render_errors: [view: SwStoreWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SwStore.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :hound,
  driver: "chrome_driver",
  host: "http://selenium",
  port: 4444,
  app_host: "http://phoenix",
  app_port: "4001",
  path_prefix: "wd/hub/"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
