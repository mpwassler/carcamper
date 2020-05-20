defmodule SwStore.Services.HikingProjectClient do  

  def handle_response({ :ok, {{'HTTP/1.1', 200, 'OK'}, _headers, _body} }) do
    _body
  end

  def handle_response({ :error, _ }) do
    '[]'    
  end

  def get_trails_from_response(%{"trails" => trails}) do 
    trails
    # Enum.map(recdata, fn data -> SwStore.Adapters.RidbAdapter.format(data) end)
  end
  
  def get_trails(latitude, longitude) do
    Application.ensure_all_started(:inets)
    Application.ensure_all_started(:ssl)
    lon = Decimal.to_string(longitude)
    lat = Decimal.to_string(latitude)     

    :httpc.request(:get, {
      'https://www.hikingproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=25&maxResults=50&key=#{System.get_env("HIKING_PROG_KEY")}', 
      []
    }, [], [])
      |> handle_response
      |> Jason.decode!
      |> get_trails_from_response
      |> IO.inspect
  end
end

