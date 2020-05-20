defmodule SwStore.Campground do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwStore.Destination

  schema "campgrounds" do
    field :address, :string
    field :checkin, :string
    field :checkout, :string
    field :latitude, :decimal
    field :longitude, :decimal
    field :name, :string
    field :phone, :string
    field :type, :string
    field :url, :string
    field :destination_id, :id

    timestamps()
  end

  def get_options_for_destination(%Destination{ latitude: latitude, longitude: longitude }) do
    SwStore.Services.RidbClient.get_facilites(longitude, latitude)
  end

  @doc false
  def changeset(campground, attrs) do
    campground
    |> cast(attrs, [:name, :latitude, :longitude, :type, :checkin, :checkout, :address, :phone, :url])
    |> validate_required([:name, :latitude, :longitude, :type, :checkin, :checkout, :address, :phone, :url])
  end
end
