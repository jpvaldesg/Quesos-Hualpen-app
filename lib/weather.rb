module Weather
require 'yahoo_weatherman'

  def temperature(lat, long)

    woeid = Weatherman::WoeidLookup.new.get_woeid("#{lat} #{long}")

    client = Weatherman::Client.new
    response = client.lookup_by_woeid woeid.to_i

    return response.condition['temp']
  end

end
