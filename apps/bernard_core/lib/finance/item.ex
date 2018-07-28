defmodule BernardCore.Finance.Item do
  @moduledoc """
  [External] The Ecto schema and changeset for the Item entity. This entity is retrieved
  from the Plaid financial API. Items represent connections between a Plaid
  Account and a bank institution. Items have many transactions

  ## Notes

    Ensure :access_token and :item_id are never exposed client-side

  """

  use BernardCore.Schema

  import Ecto.Changeset

  alias BernardCore.Accounts.User
  alias BernardCore.Finance.Transaction

  schema "items" do
    field :access_token, :string
    field :item_id, :string

    has_many  :transactions, Transaction

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:access_token, :item_id])
    |> cast_assoc(:transactions, with: &Transaction.changeset/2, required: false)
    |> validate_required([:access_token, :item_id])
    |> unique_constraint(:access_token)
    |> unique_constraint(:item_id)
  end
end
