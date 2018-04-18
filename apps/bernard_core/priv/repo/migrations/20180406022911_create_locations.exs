defmodule BernardCore.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :address, :string
      add :city, :string
      add :lat, :float
      add :lon, :float
      add :state, :string
      add :zip, :string

      timestamps()
    end

    create unique_index(:locations, [:address, :city, :state, :zip])
  end
end
