defmodule BernardApi.Schema do
  use Absinthe.Schema

  import_types BernardApi.Users
  import_types BernardApi.Users.AllUsers
  import_types BernardApi.Users.CreateUser

  query do
    import_fields :all_users
  end

  mutation do
    import_fields :create_user
  end
end
