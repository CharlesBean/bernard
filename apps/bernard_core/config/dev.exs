use Mix.Config

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Dyanmic configuration of the repo is set in
# Repo.init/2. Please be sure to have the
# following environment variables set:
#   DATABASE_USERNAME -> :username
#   DATABASE_PASSWORD -> :password
#   DATABASE_NAME     -> :database
config :bernard_core, BernardCore.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: "localhost",
  pool_size: 10
