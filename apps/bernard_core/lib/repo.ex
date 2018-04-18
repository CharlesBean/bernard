defmodule BernardCore.Repo do
  use Ecto.Repo, otp_app: :bernard_core

  @doc """
  Dynamically loads environment variables to populate the config with
  """
  def init(_, config) do
    {:ok, get_env_vars(config)}
  end

  defp get_env_vars(config) do
    env_vars = [
      url:        System.get_env("DATABASE_URL"),
      database:   System.get_env("DATABASE_NAME")     || (raise "Environment variable DATABASE_NAME is missing"),
      password:   System.get_env("DATABASE_PASSWORD") || (raise "Environment variable DATABASE_PASSWORD is missing"),
      username:   System.get_env("DATABASE_USERNAME") || (raise "Environment variable DATABASE_USERNAME is missing")
    ]

    env_vars ++ config
  end
end
