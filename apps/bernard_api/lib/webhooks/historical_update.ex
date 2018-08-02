defmodule BernardApi.Webhooks.HistoricalUpdate do
  @moduledoc """
  Handles Plaid updates via an http Webhook. Webhook data does not include specifics
  and so will require subsequent requests to Plaid for information on the updated entities
  """

  require Logger

  use Phoenix.Controller

  @doc """
  Will need to pull the latest stored transaction's date and query from then until now
  """
  def historical_update(conn, params = %{"error" => _error, "item_id" => _item_id, "new_transactions" => _new_transactions, "webhook_code" => _webhook_code, "webhook_type" => _webhook_type}) do
    json(conn, params)
  end
end
