defmodule BernardCore.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :access_token, :string, null: false
      add :item_id, :string, null: false

      add :user_id, references(:users, on_delete: :delete_all, type: :uuid),
                    null: false

      timestamps()
    end

    create unique_index(:items, [:access_token])
    create unique_index(:items, [:item_id])
    create index(:items, [:user_id])
  end
end
