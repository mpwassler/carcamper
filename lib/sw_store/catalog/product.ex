defmodule SwStore.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "catalog_products" do
    field :description, :string
    field :name, :string
    field :price, :integer
    field :published, :boolean, default: false
    field :sku, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :sku, :published, :description])
    |> validate_required([:name, :price, :sku, :published, :description])
  end
end
