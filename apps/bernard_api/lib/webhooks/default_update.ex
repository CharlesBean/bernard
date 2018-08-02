defmodule BernardApi.Webhooks.DefaultUpdate do
  @moduledoc """
  Handles Plaid updates via an http Webhook. Webhook data does not include specifics
  and so will require subsequent requests to Plaid for information on the updated entities
  """

  require Logger

  use Phoenix.Controller

  def default_update(conn, params) do
    json(conn, params)
  end
end
