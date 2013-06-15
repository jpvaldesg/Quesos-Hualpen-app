module Stocks
require 'httparty'
require 'json'

  def getSkuInfo()
    uri="http://iic3103.ing.puc.cl/webservice/integra4/?function=getSkuInfo&key=23qlJSw"
    response=HTTParty.get(uri)
    listaProductos = JSON.parse(response.body)
    return listaProductos
  end

  def getStock(sku)
    uri="http://iic3103.ing.puc.cl/webservice/integra4/?function=getStock&key=23qlJSw&params=#{sku}"
    response=HTTParty.get(uri)
    stockProducto = JSON.parse(response.body)
    return stockProducto
  end
  
  def getInfoBodegas()
    uri="http://iic3103.ing.puc.cl/webservice/integra4/?function=getInfoBodegas&key=23qlJSw"
    response=HTTParty.get(uri)
    listaBodegas = JSON.parse(response.body)
    return listaBodegas
  end
  
  def despacharStock(almacenId,sku,units)
    uri="http://iic3103.ing.puc.cl/webservice/integra4/?function=despacharStock&key=23qlJSw&params=#{almacenId},#{sku},#{units}"
    
    return HTTParty.get(uri)
  end
  
  def moverStock(from_almacenId,to_almacenId,sku,units)
    uri="http://iic3103.ing.puc.cl/webservice/integra4/?function=moverStock&key=23qlJSw&params=#{from_almacenId},#{to_almacenId},#{sku},#{units}"
    return HTTParty.get(uri)
    
  end
end
