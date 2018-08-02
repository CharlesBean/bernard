defmodule BernardApi.Router do
  use Phoenix.Router
  import Phoenix.Controller

  pipeline :api do
    plug :accepts, ["json"]
    plug BernardApi.Context
  end

  scope "/" do
    pipe_through :api

    scope "/webhooks" do
      post "/initial_update", BernardApi.Webhooks.InitialUpdate, :initial_update
      post "/historical_update", BernardApi.Webhooks.HistoricalUpdate, :historical_update
      post "/default_update", BernardApi.Webhooks.DefaultUpdate, :default_update
      post "/transactions_removed", BernardApi.Webhooks.TransactionsRemoved, :transactions_removed
    end

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: BernardApi.Schema,
      interface: :simple,
      context: %{pubsub: BernardApi.Endpoint}

    forward "/api", Absinthe.Plug,
      schema: BernardApi.Schema

  end
end
