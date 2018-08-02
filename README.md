# Bernard

This is a personal project and is mainly for personal use/fun at the moment. It
consists currently of a GraphQL API project and an Ecto PostgreSQL project. Client
apps not implemented atm

A financial management app for families. Ideas/features:

* [x] Collect and persist bank transactions locally to keep personal records forever
* [x] Push notifications of new transactions
* [ ] Spending anaylsis
* [ ] Investment reminders or automated investments
* [ ] Budgeting in terms of future purchases instead of dollar values

## Todo

* [x] Plaid API integration
* [x] User authentication
* [ ] Deployment (via Distillery)
* [ ] Desktop client

## Running

* mix deps.get
* mix ecto.reset
* mix phx.server
