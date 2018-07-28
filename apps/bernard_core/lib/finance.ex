defmodule BernardCore.Finance do
  @moduledoc false

  import Ecto.Query, warn: false

  alias BernardCore.Repo
  alias BernardCore.Finance.Item

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
end
