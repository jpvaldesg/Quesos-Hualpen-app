class Processor < ActiveRecord::Base
  include Mailer
  include Map
  include ClientAddress
  include Reservas
  include Twit
  # attr_accessible :title, :body
  def start()
  		pedidos=load_orders()
  		pedidos.each do |pedido|
  		if pedido[:rut]== "34.242.924-1"do
  			#sacar de bodega
 	 		end
 	 	pedido[:state]="despachado"

 	 	direccion=get_address(pedido[:addressId])
 	 	mensaje="Se han despachado #{pedido[:qty]} #{pedido[:unit]} del producto sku:#{pedido[:sku]}"
 	 	pedido[:state] = "despachado"
 	 	new_marker(direccion, mensaje, pedido[:orderDate])
  		end


  end 
end
