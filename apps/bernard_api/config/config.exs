# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configure phoenix generators
config :phoenix, :generators,
  migration: false

# Configures the endpoint
config :bernard_api, BernardApi.Endpoint,
  url: [host: "localhost"],
  ecto_repos: [BernardCore.Repo],
  pubsub: [name: BernardApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configure Guardian for API authentication via token
config :bernard_api, BernardApi.Guardian,
  issuer: "bernard_api",
  secret_key: {BernardApi.Config, :get_system_variable, ["API_JWT_SECRET_KEY"]}

# Configure our Plaid API connection information and credentials
# config :bernard_api, :plaid,
#   secret: {BernardApi.Config, :get_system_variable, ["PLAID_SECRET"]},
#   public_key: {BernardApi.Config, :get_system_variable, ["PLAID_PUBLIC_KEY"]},
#   client_id: {BernardApi.Config, :get_system_variable, ["PLAID_CLIENT_ID"]}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
