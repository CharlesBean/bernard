defmodule BernardCore.Geo.Location do
  @moduledoc """
  [Internal] The Ecto schema and changeset for the Location entity. This entity may
  be retrieved from various external APIs and is unique via a combination of fields.
  Locations represent any point on the earth's surface. Locations can have
  many Transactions
  """

  use BernardCore.Schema

  import Ecto.Changeset

  alias BernardCore.Finance.Transaction

  schema "locations" do
    field :address, :string
    field :city, :string
    field :lat, :float
    field :lon, :float
    field :state, :string
    field :store_number, :string
    field :zip, :string

    has_many :transactions, Transaction

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:address, :city, :lat, :lon, :state, :store_number, :zip])
    |> validate_required([:address, :city, :lat, :lon, :state, :store_number, :zip])
  end
end
