defmodule SwStoreWeb.DestinationController do
  use SwStoreWeb, :controller

  alias SwStore.Repo
  alias SwStore.Destination

  def index(_conn, _params) do
  end

  def new(conn, %{"trip_id" => trip_id}) do
    changeset = Destination.changeset(%Destination{}, %{})
    render(conn, "new.html", 
      changeset: changeset,
      trip_id: trip_id )
  end

  def create(conn, %{"destination" => destination_params, "trip_id" => trip_id }) do
    case save_destination(Map.merge(destination_params, %{"trip_id" => trip_id})) do
      {:ok, destination} ->
        conn
        |> put_flash(:info, "destination created successfully.")
        |> redirect(to: Routes.trip_path(conn, :show, trip_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, 
               "new.html", 
               changeset: changeset,
               trip_id: trip_id
    end
  end

  def show(_conn, %{"id" => id}) do
  end

  def edit(_conn, %{"id" => id}) do
  end

  def update(_conn, %{"id" => id}) do
  end

  def delete(_conn, %{"id" => id}) do
  end

  def save_destination(params) do
	  %Destination{}
	    |> Destination.changeset(params)
	    |> Repo.insert()
  end
end