module ClientAddress 
  def get_address(id)
  	a=Address.find(id)
  	idComuna=a.comunaId
  	c=Commune.find(idComuna)
  	r=Region.find(c.regionId)
  	str=a.direccion+' '+a.num+', '+c.nombre+', '+r.nombre
  	return str

  end
end