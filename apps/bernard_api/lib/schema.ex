defmodule BernardApi.Schema do
  use Absinthe.Schema

  import_types BernardApi.Users
  import_types BernardApi.Users.AllUsers
  import_types BernardApi.Users.CreateUser
  import_types BernardApi.Users.LoginUser

  query do
    import_fields :all_users
  end

  mutation do
    import_fields :create_user
    import_fields :login_user
  end
end
