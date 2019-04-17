defmodule BernardApi.Endpoint do

  use Phoenix.Endpoint, otp_app: :bernard_api
  use Absinthe.Phoenix.Endpoint

  alias BernardApi.Config

  socket "/socket", BernardApi.Sockets.TransactionSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  # plug Plug.Static,
  #   at: "/", from: :bernard_api, gzip: false,
  #   only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_bernard_api_key",
    signing_salt: "tXa0SXLf"

  # May remove the router.ex file to just use graphql
  # https://hexdocs.pm/absinthe/plug-phoenix.html#content
  # plug Absinthe.Plug,
  #   schema: BernardApi.Schema

  # Plug the Router (removable if only GraphQL)
  plug BernardApi.Router

  @doc """
  Callback invoked for dynamically configuring the endpoint.

  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_key, config) do
    {:ok, get_env_vars(config)}
  end

  defp get_env_vars(config) do
    env_vars = [
      http: [
        port: String.to_integer(Config.get_system_variable("API_PORT"))
      ],
      secret_key_base: Config.get_system_variable("API_PORT")
    ]

    env_vars ++ config
  end
end
