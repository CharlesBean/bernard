# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BernardCore.Repo.insert!(%BernardCore.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BernardCore.Repo
alias BernardCore.Accounts.Credential
alias BernardCore.Accounts.User

%User{name: "Charles Bean", credentials: [%Credential{email: "beanchar@msu.edu"}]} |> Repo.insert!
