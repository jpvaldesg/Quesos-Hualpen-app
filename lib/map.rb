module Map
  def new_marker(dir, desc, final)
  
    require 'gmaps4rails'
    coordenates = Gmaps4rails.geocode(dir)
    
    dis = Dispatch.new()

    dis[:direction] = dir
    dis[:description] = desc
    dis[:final] = final

    dis[:latitude] = coordenates[0][:lat]
    dis[:longitude] = coordenates[0][:lng]
    dis[:gmaps] = 1

    dis.save

  end
end
