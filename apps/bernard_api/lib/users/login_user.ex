defmodule BernardApi.Users.LoginUser do
  @moduledoc """
  Logs in a User and returns access and refresh tokens for authentication
  """

  use Absinthe.Schema.Notation

  import Comeonin.Pbkdf2, only: [checkpw: 2]

  alias BernardCore.Accounts.Credential
  alias BernardCore.Repo

  object :login_user do
    @desc "Login a user"
    field :login_user, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &login_user/3
    end
  end

  @doc false
  defp login_user(_root, %{email: email, password: password}, _info) do
    with  {:ok, user}                   <- login_with_email_pass(email, password),
          {:ok, access_token, _claims}  <- BernardApi.Guardian.encode_and_sign(user),
          {:ok, refresh_token, _claims} <- BernardApi.Guardian.encode_and_sign(user, %{}, token_type: "refresh")
    do
      {:ok, %{access_token: access_token, refresh_token: refresh_token}}
    end
  end

  @doc false
  defp login_with_email_pass(email, given_pass) do
    credential = Repo.get_by(Credential, email: email)
      |> Repo.preload(:user)

    user = credential.user

    cond do
      user && checkpw(given_pass, credential.password_hash) ->
        {:ok, user}
      user ->
        {:error, "Incorrect login credentials"}
      true ->
        {:error, :"User not found"}
    end
  end
end
