defmodule BernardApi.Users do
  @moduledoc """
  Represents a user internal to this system. Users can have many Items, etc.
  """

  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:string)
    field :name, non_null(:string)
    field :credentials, list_of(non_null(:credential))
  end

  object :credential do
    field :email, non_null(:string)
  end
end
