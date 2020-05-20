defmodule SwStore.Repo.Migrations.CreateTrails do
  use Ecto.Migration

  def change do
    create table(:trails) do
      add :name, :string
      add :latitude, :decimal
      add :longitude, :decimal
      add :length, :decimal
      add :description, :string
      add :vertical_gain, :decimal
      add :map_url, :string
      add :destination_id, references(:destination, on_delete: :nothing)

      timestamps()
    end

    create index(:trails, [:destination_id])
  end
end
