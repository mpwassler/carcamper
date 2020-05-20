defmodule SwStoreWeb.TrailController do
  use SwStoreWeb, :controller

  alias SwStore.Repo
  alias SwStore.Trail
  alias SwStore.Destination

  def new(conn, %{"destination_id" => destination_id}) do
    changeset = Trail.changeset(%Trail{}, %{})
    destination = Repo.get!(Destination, destination_id)
    options = Trail.get_options_for_destination(destination)
    render(conn, "new.html", 
      changeset: changeset, 
      options: options,
      destination: destination)
  end

  def save_trail(params) do
	  %Trail{}
	    |> Trail.changeset(params)
	    |> Repo.insert()
  end
end