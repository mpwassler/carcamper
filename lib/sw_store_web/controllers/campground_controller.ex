defmodule SwStoreWeb.CampgroundController do
  use SwStoreWeb, :controller

  alias SwStore.Repo
  alias SwStore.Campground
  alias SwStore.Destination

  def new(conn, %{"destination_id" => destination_id}) do
    destination = Repo.get!(Destination, destination_id)
    options = Campground.get_options_for_destination(destination)
    changeset = Campground.changeset(%Campground{}, %{})
    
    render(conn, "new.html", 
      changeset: changeset,
      destination: destination,
      options: options
    )
  end

  def save_destination(params) do
	  %Campground{}
	    |> Campground.changeset(params)
	    |> Repo.insert()
  end
end