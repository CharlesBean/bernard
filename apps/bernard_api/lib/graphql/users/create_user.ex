defmodule BernardApi.GraphQL.Users.CreateUser do
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
      arg :password, non_null(:string)

      resolve &create_user/3
    end
  end

  @doc false
  defp create_user(_root, %{email: email, name: name, password: password}, _info) do
    attrs = %{:name => name, :credentials => [ %{ :email => email, :password => password } ]}
    Accounts.create_user(attrs)
  end
end
