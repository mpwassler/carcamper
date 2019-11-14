defmodule SwStoreWeb.TripsTest do
  use ExUnit.Case  
  # Import helpers
  use Hound.Helpers

  use SwStoreWeb.ConnCase, async: true
  # Start hound session and destroy when tests are run
  hound_session()

  test "shows a page", _meta do
    navigate_to("/trips")
    assert page_title() == "Carcamper"
  end

  test "create a trip", _meta do
    navigate_to("/trips/new")
    fill_field({:id, "trip_name"}, "Utah")
    find_element(:id, "create_trip")
      |> click  
    assert visible_in_page?(~r/Trip created successfully./)
  end
end