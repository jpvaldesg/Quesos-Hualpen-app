class Processor < ActiveRecord::Base
  include Mailer
  include Map
  include ClientAddress
  include Reservas
  include Twit
  include Vtiger
  include Stocks
  # attr_accessible :title, :body
  def start()
  	pedidos=load_orders()	    
    pedidos.each do |pedido|
    	if pedido[:rut]== "34.242.924-1" 
        getStock(pedido[:sku]).each do |almacen|
          if almacen[:tipo]=="despacho"   
            if almacen[:libre]>=pedido[:qty] 
              despacharStock(almacen[:almacenId],pedido[:sku],pedido[:qty])
              pedido[:state]="despachado"
              direccion=get_address(pedido[:addressId])
              mensaje="Se han despachado #{pedido[:qty]} #{pedido[:unit]} del producto sku:#{pedido[:sku]}"
              pedido[:state] = "despachado"
              new_marker(direccion, mensaje, pedido[:orderDate])
            end
            else
              getStock(pedido[:sku]).each do |almacen2|
                if almacen2[:tipo]=="Bodega Central de libre disposicion" or almacen2[:tipo]=="recepcion"
                  moverStock(almacen2[:almacenId],almacen[:almacenId],pedido[:sku],almacen2[:libre])
                end
              end
             
              if almacen[:libre]>=pedido[:qty] 
                despacharStock(almacen[:almacenId],pedido[:sku],pedido[:qty])
                pedido[:state]="despachado"
                direccion=get_address(pedido[:addressId])
                mensaje="Se han despachado #{pedido[:qty]} #{pedido[:unit]} del producto sku:#{pedido[:sku]}"
                pedido[:state] = "despachado"
                new_marker(direccion, mensaje, pedido[:orderDate]) 
              end  
            end 
          end
        end
      end
      else
        getStock(pedido[:sku]).each do |almacen|
          if almacen[:tipo]=="despacho"   
            if almacen[:libre]>=pedido[:qty] 
              despacharStock(almacen[:almacenId],pedido[:sku],pedido[:qty])
              pedido[:state]="despachado"
              direccion=get_address(pedido[:addressId])
              mensaje="Se han despachado #{pedido[:qty]} #{pedido[:unit]} del producto sku:#{pedido[:sku]}"
              pedido[:state] = "despachado"
              new_marker(direccion, mensaje, pedido[:orderDate])
            end
            else
              getStock(pedido[:sku]).each do |almacen2|
                if almacen2[:tipo]=="Bodega Central de libre disposicion" or almacen2[:tipo]=="recepcion"
                  moverStock(almacen2[:almacenId],almacen[:almacenId],pedido[:sku],almacen2[:libre])
                end
              end
             
              if almacen[:libre]>=pedido[:qty] 
                despacharStock(almacen[:almacenId],pedido[:sku],pedido[:qty])
                pedido[:state]="despachado"
                direccion=get_address(pedido[:addressId])
                mensaje="Se han despachado #{pedido[:qty]} #{pedido[:unit]} del producto sku:#{pedido[:sku]}"
                pedido[:state] = "despachado"
                new_marker(direccion, mensaje, pedido[:orderDate]) 
              end  
            end 
          end
        end
      end 
    end
  end
end
                
>>>>>>> 0c92eed3dedfff1f29144d9eb8bbc4ce499f2973
