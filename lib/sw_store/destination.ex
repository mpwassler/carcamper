defmodule SwStore.Destination do
  use Ecto.Schema
  import Ecto.Changeset

  schema "destination" do
    field :date, :date
    field :latitude, :decimal
    field :longitude, :decimal
    field :name, :string
    field :trip_id, :id

    timestamps()
  end

  @doc false
  def changeset(destination, attrs) do
    destination
    |> cast(attrs, [:name, :latitude, :longitude, :date, :trip_id])
    |> validate_required([:name, :latitude, :longitude, :date, :trip_id])
  end
end
