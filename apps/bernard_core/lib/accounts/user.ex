defmodule BernardCore.Accounts.User do
  @moduledoc """
  [Internal] The Ecto schema and changeset information for the User entity. Users can
  have multiple Items (Finance) and Credentials (Auth)
  """

  use BernardCore.Schema

  import Ecto.Changeset

  alias BernardCore.Accounts.{User, Credential}
  alias BernardCore.Finance.Item

  schema "users" do
    field :name, :string

    has_many :credentials, Credential
    has_many :items, Item

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
