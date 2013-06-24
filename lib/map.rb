module Map
  def new_marker(dir, desc, final)
  
    require 'gmaps4rails'
	
	begin
	Gmaps4Rails.set_gmaps4rails_options!({:validation => false})
    coordenates = Gmaps4rails.geocode(dir)
    if coordenates != nil
      dis = Dispatch.new()

      dis[:direction] = dir
      dis[:description] = desc
      dis[:final] = final

      dis[:latitude] = coordenates[0][:lat]
      dis[:longitude] = coordenates[0][:lng]
      dis[:gmaps] = 1

      dis.save
	end
    return dis
	
	rescue
	return nil
	
	end
  end
end
