defmodule BernardCore.Accounts.Credential do
  @moduledoc """
  [Internal] The Ecto schema and changeset for the Credential entity. Credentials
  are used to authenticate users. A User can have multiple
  """

  use BernardCore.Schema

  import Ecto.Changeset

  alias BernardCore.Accounts.{Credential, User}

  schema "credentials" do
    field :email, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
