defmodule SwStore.Repo.Migrations.CreateDestination do
  use Ecto.Migration

  def change do
    create table(:destination) do
      add :name, :string
      add :latitude, :decimal
      add :longitude, :decimal
      add :date, :date
      add :trip_id, references(:trip, on_delete: :nothing)

      timestamps()
    end

    create index(:destination, [:trip_id])
  end
end
