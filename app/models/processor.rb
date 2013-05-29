class Processor < ActiveRecord::Base
  require 'mailer'
  extend Mailer
  require 'map'
  extend Map
  require 'client_address'
  extend ClientAddress
  require 'stocks'
  extend Stocks
  # attr_accessible :title, :body
  def self.start()
      pedidos=load_orders()
      pedidos.each do |pedido|
              direccion=get_address(pedido[:addressId])
              mensaje="Se han despachado #{pedido[:qty]} #{pedido[:unit]} del producto sku:#{pedido[:sku]}"
              pedido[:state] = "despachado"
              new_marker(direccion, mensaje, pedido[:orderDate])
              pedido.save
      end

      end  
end

                
