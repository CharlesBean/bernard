defmodule BernardApi.Users do
  @moduledoc """
  Represents a user internal to this system. Users can have many Items, etc.
  """

  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:string)
    field :credentials, list_of(non_null(:credential))
    field :name, non_null(:string)
  end

  object :credential do
    field :email, non_null(:string)
  end

  object :session do
    field :access_token, non_null(:string)
    field :refresh_token, non_null(:string)
  end
end
