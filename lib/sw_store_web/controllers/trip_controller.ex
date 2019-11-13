defmodule SwStoreWeb.TripController do
  use SwStoreWeb, :controller

  alias SwStore.Repo
  alias SwStore.Trip

  def index(conn, _params) do
    trips = Repo.all(Trip)
    render(conn, "index.html", trips: trips)
  end

  def new(conn, _params) do
  	changeset = Trip.changeset(%Trip{}, %{})
  	render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"trip" => trip_params}) do  	  	
    case save_trip(trip_params) do
      {:ok, trip} ->
        conn
        |> put_flash(:info, "Trip created successfully.")
        |> redirect(to: Routes.trip_path(conn, :show, trip))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end  	
  end

  def show(conn, %{"id" => id}) do
  	trip = Trip 
  		|> Repo.get!(id)
  		|> Repo.preload(:destination) 
  	IO.inspect(trip)
    render(conn, "show.html", trip: trip)
  end

  def edit(conn, %{"id" => id}) do
  	trip = Repo.get!(Trip, id)
    render(conn, "show.html", trip: trip)
  end

  def update(conn, %{"id" => id}) do
  	trip = Repo.get!(Trip, id)
    render(conn, "show.html", trip: trip)
  end

  def delete(conn, %{"id" => id}) do
  	trip = Repo.get!(Trip, id)
    render(conn, "show.html", trip: trip)
  end

  def save_trip(params) do
	%Trip{}
	  |> Trip.changeset(params)
	  |> Repo.insert()
  end
end