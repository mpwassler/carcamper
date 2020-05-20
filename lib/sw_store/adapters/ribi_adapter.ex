
defmodule SwStore.Adapters.RidbAdapter do  
  def parse_address(%{ 
    "FACILITYADDRESS" => [ %{
        "FacilityStreetAddress2" => "",
        "City" => "",      
      } ] 
  }) do 
    nil 
  end

  def parse_address(%{ 
    "FACILITYADDRESS" => [ %{
        "FacilityStreetAddress2" => street2,
        "City" => city,
        "AddressStateCode" => state,
        "PostalCode" => zip,
      } ] 
  }) do 
    "#{street2} #{city}, #{state} #{zip}" 
  end

  def parse_address( _ ) do nil end

  def format(campground) do   
    %{
      address: parse_address(campground),
      checkin: "NA",
      checkout: "NA",
      latitude: campground["FacilityLatitude"],
      longitude: campground["FacilityLongitude"],
      name: campground["FacilityName"] ,
      phone: campground["FacilityPhone"],
      type: "NA",
      url: campground["FacilityReservationURL"],
      description: campground["FacilityDescription"],
      email: campground["FacilityEmail"]
    }
  end  
end