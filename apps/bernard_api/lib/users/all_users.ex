defmodule BernardApi.Users.AllUsers do
  @moduledoc """
  Retrieves all users
  """

  use Absinthe.Schema.Notation

  alias BernardCore.Accounts

  object :all_users do
    @desc "Retrieve all users"
    field :all_users, non_null(list_of(non_null(:user))) do
      resolve &all_users/3
    end
  end

  @doc false
  defp all_users(_root, _args, %{context: %{current_user: _current_user}}) do
    users = Accounts.list_users()
    {:ok, users}
  end

  @doc false
  defp all_users(_root, _args, _info) do
    {:error, "Not authenticated"}
  end
end
