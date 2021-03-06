defmodule BernardCore.Finance.Transaction do
  @moduledoc """
  [External] Ecto schema and changeset information for the Transaction entity.
  Is retrieved from the Plaid financial API. Transactions may have a Location
  associated with them and will always have an Item associated
  """

  use BernardCore.Schema

  import Ecto.Changeset

  alias BernardCore.Geo.Location
  alias BernardCore.Finance.Item

  schema "transactions" do
    field :account_id, :string
    field :amount, :float
    field :category, {:array, :string}
    field :category_id, :string
    field :date, :string
    field :name, :string
    field :pending, :boolean
    field :pending_transaction_id, :string
    field :transaction_id, :string
    field :transaction_type, :string

    belongs_to :item, Item
    belongs_to :location, Location

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:account_id, :amount, :category, :category_id, :date, :name, :pending, :pending_transaction_id, :transaction_id, :transaction_type])
    |> validate_required([:account_id, :amount, :category, :category_id, :date, :name, :pending, :transaction_id, :transaction_type])
  end
end
