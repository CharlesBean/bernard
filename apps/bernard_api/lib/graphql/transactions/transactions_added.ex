defmodule BernardApi.GraphQL.Transactions.TransactionsAdded do
  @moduledoc """
  Subscription for clients to receive server messages about newly added transactions
  """

  use Absinthe.Schema.Notation

  object :transactions_added do
    @desc "Notifies clients of new transactions"
    field :transactions_added, non_null(list_of(non_null(:transaction))) do
      arg :user_id, type: non_null(:string)

      config fn args, _info ->
        {:ok, topic: args.user_id}
      end

      resolve fn transactions, _, _ ->
        {:ok, transactions}
      end
    end
  end
end
