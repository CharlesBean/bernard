use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

# Dyanmic configuration of the repo is set in
# Repo.init/2. Please be sure to have the
# following environment variables set:
#   DATABASE_USERNAME -> :username
#   DATABASE_PASSWORD -> :password
#   DATABASE_NAME     -> :database
config :bernard_core, BernardCore.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
