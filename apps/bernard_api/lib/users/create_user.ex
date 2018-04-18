defmodule BernardApi.Users.CreateUser do
  @moduledoc """
  Creates a new user
  """

  use Absinthe.Schema.Notation

  require Logger

  alias BernardCore.Accounts

  object :create_user do
    @desc "Create a user"
    field :create_user, :user do
      arg :email, non_null(:string)
      arg :name, non_null(:string)
      arg :username, non_null(:string)

      resolve &create_user/3
    end
  end

  @doc false
  defp create_user(_root, %{email: email, username: username, name: name}, _info) do
    attrs = %{:username => username, :name => name, :credentials => [ %{ :email => email } ]}
    Accounts.create_user(attrs)
  end
end
