defmodule BernardApi.Clients.Plaid do
  @moduledoc """
  Extends HTTPoison.Base to wrap the Plaid HTTP API
  """

  use HTTPoison.Base

  require Logger

  alias Poison
  alias HTTPoison
  alias BernardApi.Config

  def list_transactions(access_token, start_date, end_date) do
    case post("/transactions/get", %{
      :access_token => access_token,
      :start_date => start_date,
      :end_date => end_date
    }) do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, body["transactions"]}
      _error -> {:error, "Could not query Plaid correctly"}
    end
  end

  def exchange_token(public_token) do
    case post("/item/public_token/exchange", %{
      public_token: public_token                    # public-sandbox-68358d43-3427-45eb-8375-183cf4ea0d03
    }) do
      {:ok, %HTTPoison.Response{:body => %{"error_message" => error_message}}} ->
        {:error, error_message}
      {:ok, %HTTPoison.Response{body: body}} ->
        item = %{
          :access_token => body["access_token"],    # access-sandbox-e47c753f-e677-4e75-a2c4-93d987fb5528
          :item_id => body["item_id"]               # 1G57WnAVJXhdG6kL5XZBIdgJzMDx7QTEA78g1
        }
        {:ok, item}
      {_error, _response} ->
        {:error, "Failed to create item"}
    end
  end

  @doc """
  Overrides the process_url HTTPoison.Base function to build a Plaid uri scheme
  """
  def process_url(url) do
    Application.get_env(:bernard_api, :plaid)[:host] <> url
  end

  @doc """
  Overrides the process_request_body HTTPoison.Base function to alter a request body before sending
  """
  def process_request_body(body) do
    # client_id       = Application.get_env(:bernard_api, :plaid)[:client_id]
    # secret          = Application.get_env(:bernard_api, :plaid)[:secret]
    client_id       = Config.get_system_variable("PLAID_CLIENT_ID")
    secret          = Config.get_system_variable("PLAID_SECRET")
    body            = Map.merge(body, %{ :client_id => client_id, :secret => secret })
    Poison.encode!(body)
  end

  @doc """
  Overrides the process_request_headers HTTPoison.Base function to alter request headers before sending
  """
  def process_request_headers(headers) do
    headers ++ [{"Content-type", "application/json"}]
  end

  @doc """
  Overrides the process_response_body HTTPoison.Base function to alter a response body after response received
  """
  def process_response_body(body) do
    # Logger.info fn ->
    #   "[Bernard] Plaid returned: #{inspect body}"
    # end
    Poison.decode!(body)
  end
end
