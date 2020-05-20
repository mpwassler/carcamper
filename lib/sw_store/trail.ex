defmodule SwStore.Trail do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwStore.Destination

  schema "trails" do
    field :description, :string
    field :latitude, :decimal
    field :length, :decimal
    field :longitude, :decimal
    field :map_url, :string
    field :name, :string
    field :vertical_gain, :decimal
    field :destination_id, :id

    timestamps()
  end

  def get_options_for_destination(%Destination{ latitude: latitude, longitude: longitude }) do
    SwStore.Services.HikingProjectClient.get_trails(longitude, latitude)
  end

  @doc false
  def changeset(trail, attrs) do
    trail
    |> cast(attrs, [:name, :latitude, :longitude, :length, :description, :vertical_gain, :map_url])
    |> validate_required([:name, :latitude, :longitude, :length, :description, :vertical_gain, :map_url])
  end
end
