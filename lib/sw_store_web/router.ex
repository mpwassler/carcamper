defmodule SwStoreWeb.Router do
  use SwStoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SwStoreWeb do
    pipe_through :browser

    resources "/trips", TripController do 
       get "/destinations/new", DestinationController, :new
       post "/destinations/new", DestinationController, :create
       get "/destinations/:id/edit", DestinationController, :edit
    end

    resources "/products", ProductController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SwStoreWeb do
  #   pipe_through :api
  # end
end
