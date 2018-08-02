defmodule BernardCore.Finance do
  @moduledoc false

  import Ecto.Query, warn: false

  alias BernardCore.Repo
  alias BernardCore.Finance.Item
  alias BernardCore.Finance.Transaction

  @doc """
  Returns the list of transactions for a user over a given time
  """
  def list_transactions(user_ids \\ []) when is_list(user_ids) do
    Repo.all from i in Item,
      join: t in assoc(i, :transactions),
      where: i.user_id in ^user_ids,
      select: t
  end

  @doc """
  Creates a new item for a user. Represents a connection to an account
  """
  def create_item(user_id, attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Ecto.Changeset.put_change(:user_id, user_id)
    |> Repo.insert()
  end

  @doc """
  Adds transactions for an Item. Skips existing transactions via "transaction_id" uniqueness

  :|PERFORMANCE Update to use Repo.insert_all
  """
  def create_transactions(item_id, [%{} = _head|_tail] = transactions) do

    existing_transaction_ids = Repo.all from t in Transaction,
      where: t.item_id == ^item_id,
      select: t.transaction_id

    changesets = transactions
      |> Enum.filter(fn t ->
        !Enum.any?(existing_transaction_ids, fn transaction_id -> transaction_id == t["transaction_id"] end)
      end)
      |> Enum.map(fn t ->
        %Transaction{:item_id => item_id}
        |> Transaction.changeset(t)
      end)

    _multi_result = changesets
      |> Enum.with_index()
      |> Enum.reduce(Ecto.Multi.new(), fn ({changeset, index}, multi) ->
        Ecto.Multi.insert(multi, Integer.to_string(index), changeset)
      end)
      |> Repo.transaction
  end
end
