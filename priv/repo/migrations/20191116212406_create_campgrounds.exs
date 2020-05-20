defmodule SwStore.Repo.Migrations.CreateCampgrounds do
  use Ecto.Migration

  def change do
    create table(:campgrounds) do
      add :name, :string
      add :latitude, :decimal
      add :longitude, :decimal
      add :type, :string
      add :checkin, :string
      add :checkout, :string
      add :address, :string
      add :phone, :string
      add :url, :string
      add :destination_id, references(:destination, on_delete: :nothing)

      timestamps()
    end

    create index(:campgrounds, [:destination_id])
  end
end
