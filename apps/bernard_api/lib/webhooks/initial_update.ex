defmodule BernardApi.Webhooks.InitialUpdate do
  @moduledoc """
  Handles Plaid updates via an http Webhook. Webhook data does not include specifics
  and so will require subsequent requests to Plaid for information on the updated entities
  """

  require Logger

  use Phoenix.Controller

  alias BernardApi.Clients.Plaid
  alias BernardCore.Finance
  alias BernardCore.Finance.Item
  alias BernardCore.Repo
  alias Absinthe.Subscription

  @doc """
  Executes X GET transactions requests to Plaid for a given item_id, where X is the number of new
  transactions divided by the maximum number of transactions per request (500)

  Uses an Ecto multi request to store the returned transactions in PostgreSQL

  Uses a GraphQL subscription to dispatch a transactions_added message to all connected clients

  :|PERFORMANCE Shift from awaiting one request at a time to awaiting all
  :|SECURITY    Determine what to return
  """
  def initial_update(conn, _params = %{"error" => _error, "item_id" => item_id, "new_transactions" => new_transactions, "webhook_code" => _webhook_code, "webhook_type" => _webhook_type}) do

    item          = Repo.get_by!(Item, item_id: item_id)
    access_token  = Map.fetch!(item, :access_token)
    start_date    = Date.add(Date.utc_today(), -30) |> Date.to_iso8601
    end_date      = Date.utc_today() |> Date.to_iso8601
    num_requests  = Float.ceil(new_transactions / 500) |> trunc

    for _n <- 0..num_requests do
      case Plaid.list_transactions(access_token, start_date, end_date, new_transactions) do
        {:ok, data} ->
          case Finance.create_transactions(item.id, data) do
            {:ok, multi_result} ->
              added_transactions = multi_result
              Subscription.publish(BernardApi.Endpoint, added_transactions, transactions_added: item.user_id)
              json(conn, Map.values(added_transactions))
            {:error, _, _changeset, _} ->
              json(conn, "Failed to insert 1 or more changesets")
          end
        {:error, _data} ->
          json(conn, "Failed to retrieve transactions from Plaid")
      end
    end

    json(conn, "Failed to make Plaid requests - number of new transactions resulted in range issues")
  end
end
