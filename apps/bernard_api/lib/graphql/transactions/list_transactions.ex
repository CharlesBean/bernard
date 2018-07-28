defmodule BernardApi.GraphQL.Transactions.ListTransactions do
  @moduledoc """
  Retrieves transactions
  """

  use Absinthe.Schema.Notation

  require Logger

  alias BernardCore.Finance
  # alias BernardCore.Repo

  object :list_transactions do
    @desc "Retrieve transactions"
    field :list_transactions, non_null(list_of(:transaction)) do
      arg :user_ids, type: non_null(list_of(non_null(:string)))
      resolve &list_transactions/3
    end
  end

  @doc false
  defp list_transactions(_root, %{user_ids: user_ids} = _args, %{context: %{current_user: _current_user}}) do
    {:ok, Finance.list_transactions(user_ids)}
  end

  defp list_transactions(_root, %{user_ids: user_ids} = _args, _context) do
    # {:error, "Not Authenticated"}
    # user_id = user_ids |> List.first
    # item    = Repo.get_by(Finance.Item, user_id: user_id)
    # Logger.info("#{inspect(item)}")
    # transactions = Enum.reduce(items, fn (item, accum) -> accum.concat(Plaid.list_transactions(item.access_token, "2017-01-01", "2018-01-01")) end)
    {:ok, Finance.list_transactions(user_ids)}
  end
end
