defmodule BernardCore.Accounts.Credential do
  @moduledoc """
  [Internal] The Ecto schema and changeset for the Credential entity. Credentials
  are used to authenticate users. A User can have multiple
  """

  use BernardCore.Schema

  import Ecto.Changeset

  alias BernardCore.Accounts.User

  schema "credentials" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(password)
  end

  defp hash_password(_ = changeset) do
    changeset
  end
end
