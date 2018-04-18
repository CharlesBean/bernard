defmodule BernardApi.Router do
  use Phoenix.Router
  import Phoenix.Controller

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: BernardApi.Schema,
      interface: :simple,
      context: %{pubsub: BernardApi.Endpoint}

    forward "/api", Absinthe.Plug,
      schema: BernardApi.Schema

  end
end
