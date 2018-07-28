use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
#
# Dyanmic configuration of the endpoint is set in
# Endpoint.init/2. Please ensure to have the following
# environment variables set:
#   API_PORT              -> :http[:port]
#   API_SECRET_KEY_BASE   -> :secret_key_base
config :bernard_api, BernardApi.Endpoint,
  http: [],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure Plaid API connection info
config :bernard_api, :plaid,
  host: "https://development.plaid.com"
