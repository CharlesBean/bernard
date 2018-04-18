use Mix.Config

# Do not print debug messages in production
config :logger, level: :info

# Dyanmic configuration of the repo is set in
# Repo.init/2. Please be sure to have the
# following environment variables set:
#   DATABASE_USERNAME -> :username
#   DATABASE_PASSWORD -> :password
#   DATABASE_NAME     -> :database
config :bernard_core, BernardCore.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: 15
