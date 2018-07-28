defmodule BernardApi.GraphQL.Transactions do

  use Absinthe.Schema.Notation

  object :transaction do
    field :id, non_null(:string)
    field :account_id, non_null(:string)
    field :amount, non_null(:float)
    field :category, non_null(:string)
    field :date, non_null(:string)
    field :name, non_null(:string)
    field :pending, non_null(:boolean)
    field :pending_transaction_id, :string
    field :transaction_id, non_null(:string)
    field :transaction_type, non_null(:string)
  end
end
