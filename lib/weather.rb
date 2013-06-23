module Weather
require 'yahoo_weatherman'
require 'gmaps4rails'

  def temperature(lat, long)

    woeid = Weatherman::WoeidLookup.new.get_woeid("#{lat} #{long}")

    client = Weatherman::Client.new
    response = client.lookup_by_woeid woeid.to_i

    return response.condition['temp']
  end
  
  def temperature_by_place(dir)
  
    coordenates = Gmaps4rails.geocode(dir)
	lat = coordenates[0][:lat]
	long = coordenates[0][:lng]
	
	woeid = Weatherman::WoeidLookup.new.get_woeid("#{lat} #{long}")

    client = Weatherman::Client.new
    response = client.lookup_by_woeid woeid.to_i

    return response.condition['temp']
	
  end

end
