defmodule SwStore.Repo.Migrations.CreateTrip do
  use Ecto.Migration

  def change do
    create table(:trip) do
      add :title, :string

      timestamps()
    end

  end
end
