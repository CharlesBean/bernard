defmodule BernardApi.GraphQL.Items do

  use Absinthe.Schema.Notation

  object :item do
    field :id, non_null(:string)
    field :user_id, non_null(:string)
    field :item_id, non_null(:float)
    field :access_token, non_null(:string)
  end
end
