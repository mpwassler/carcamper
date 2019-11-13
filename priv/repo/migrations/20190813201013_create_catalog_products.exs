defmodule SwStore.Repo.Migrations.CreateCatalogProducts do
  use Ecto.Migration

  def change do
    create table(:catalog_products) do
      add :name, :string
      add :price, :integer
      add :sku, :string
      add :published, :boolean, default: false, null: false
      add :description, :text

      timestamps()
    end

  end
end
