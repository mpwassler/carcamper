defmodule SwStore.Trip do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trip" do
    field :title, :string
    has_many :destination, SwStore.Destination
    timestamps()
  end

  @doc false
  def changeset(trip, attrs) do
    trip
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
