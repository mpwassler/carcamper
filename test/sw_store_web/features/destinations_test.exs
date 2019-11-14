defmodule SwStoreWeb.DestinationsTest do
  use ExUnit.Case  
  # Import helpers
  use Hound.Helpers
  use SwStoreWeb.ConnCase, async: true
  
  # Start hound session and destroy when tests are run
  hound_session()

  test "shows a page", _meta do
    SwStore.Repo.insert!(%SwStore.Trip{ title: "Test Trip" })
    trip = SwStore.Trip |> SwStore.Repo.one
    navigate_to("/trips/#{trip.id}")
    assert visible_in_page?(~r/Test Trip/)
  end
end