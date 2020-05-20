defmodule SwStore.Services.RidbClient do  

  def handle_response({ :ok, {{'HTTP/1.1', 200, 'OK'}, _headers, _body} }) do
    _body
  end

  def handle_response({ :error, _ }) do
    '[]'    
  end

  def get_campgrounds_from_response(%{"RECDATA" => recdata}) do 
    Enum.map(recdata, fn data -> SwStore.Adapters.RidbAdapter.format(data) end)
  end
  
  def get_facilites(latitude, longitude) do
    Application.ensure_all_started(:inets)
    Application.ensure_all_started(:ssl)
    lon = Decimal.to_string(longitude)
    lat = Decimal.to_string(latitude)     
    :httpc.request(:get, {
      'https://ridb.recreation.gov/api/v1/facilities/?limit=50&offset=0&full=true&activity=CAMPING&latitude=#{lat}&longitude=#{lon}&radius=20.0', 
      [{'apikey', System.get_env("RECGOV_KEY")}]
      
    }, [], [])
      |> handle_response
      |> Jason.decode!
      |> get_campgrounds_from_response
      |> IO.inspect
  end
end

