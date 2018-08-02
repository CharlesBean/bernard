defmodule BernardApi.Schema do
  use Absinthe.Schema

  import_types BernardApi.GraphQL.Users
  import_types BernardApi.GraphQL.Users.AllUsers
  import_types BernardApi.GraphQL.Users.CreateUser
  import_types BernardApi.GraphQL.Users.LoginUser

  import_types BernardApi.GraphQL.Transactions
  import_types BernardApi.GraphQL.Transactions.ListTransactions
  import_types BernardApi.GraphQL.Transactions.TransactionsAdded

  import_types BernardApi.GraphQL.Items
  import_types BernardApi.GraphQL.Items.CreateItem

  query do
    import_fields :all_users
    import_fields :login_user

    import_fields :list_transactions
  end

  mutation do
    import_fields :create_user
    import_fields :create_item
  end

  subscription do
    import_fields :transactions_added
  end
end
