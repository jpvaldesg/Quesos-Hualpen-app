module Contabilidad
require 'httparty'
require 'json'

  def registrar_costo(cost)
    date = Time.now.strftime("%m-%d-%Y %H:%M:%S")
    uri = URI.escape("http://iic3103.ing.puc.cl/webservice/integra4/contabilidad/?key=23qlJSw&action=cost&date=#{date}&amount=#{cost}")
    response = JSON.parse(HTTParty.get(uri).body)
    return response
  end

  def registrar_ingreso(earn)
    date = Time.now.strftime("%m-%d-%Y %H:%M:%S")
    uri = URI.escape("http://iic3103.ing.puc.cl/webservice/integra4/contabilidad/?key=23qlJSw&action=earning&date=#{date}&amount=#{earn}")
    response=JSON.parse(HTTParty.get(uri).body)
    return response
  end

end
