defmodule BernardCore.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :account_id, :string, null: false
      add :amount, :float, null: false
      add :category, {:array, :string}
      add :date, :string, null: false
      add :name, :string, null: false
      add :pending, :boolean, null: false
      add :pending_transaction_id, :string
      add :transaction_id, :string, null: false
      add :transaction_type, :string, null: false

      add :item_id, references(:items, on_delete: :delete_all, type: :uuid),
                    null: false
      add :location_id, references(:locations, on_delete: :nilify_all, type: :uuid)

      timestamps()
    end

    create unique_index(:transactions, [:transaction_id])
    create index(:transactions, [:item_id])
    create index(:transactions, [:location_id])
  end
end
