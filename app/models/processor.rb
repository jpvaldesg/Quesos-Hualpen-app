class Processor < ActiveRecord::Base
  # attr_accessible :title, :body
  include Mailer
  include Twit
  include Reservas
  include Map
  include ClientAddress 

  def start()
  	nuevosPedidos=load_orders()

  	nuevoPedidos.each do |pedido| 
  		if pedido[:rut]=="34.706.861-7" do
  			numReservas=view_reservas(pedido[:sku])

  		end
  		direccion=get_address(pedido[:addressId])
  		mensaje="Despacho de #{pedido[:qty]} #{pedido[:unit]} del producto sku:#{pedido[:sku]}"
  		pedido[:state]="despachado"
  		pedido.save
  		new_marker(direccion,mensaje,pedido[:orderDate])

  	end


  end
end
