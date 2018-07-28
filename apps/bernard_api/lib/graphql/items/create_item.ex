defmodule BernardApi.GraphQL.Items.CreateItem do
  @moduledoc """

  """

  use Absinthe.Schema.Notation

  require Logger

  alias BernardCore.Finance
  # alias BernardCore.Repo
  alias BernardApi.Clients.Plaid

  object :create_item do
    @desc "Create an item"
    field :create_item, non_null(:item) do
      arg :user_id, type: non_null(:string)
      arg :public_token, type: non_null(:string)
      resolve &create_item/3
    end
  end

  def create_item(_root, args, _info) do
    public_token  = args[:public_token]
    user_id       = args[:user_id]
    case Plaid.exchange_token(public_token) do
      {:ok, item} ->
        Finance.create_item(user_id, item)
      {:error, response} ->
        {:error, response}
    end
  end
end
