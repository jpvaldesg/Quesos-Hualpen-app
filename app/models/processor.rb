class Processor < ActiveRecord::Base
	require 'mailer'
	extend Mailer
	require 'map'
	extend Map
	require 'client_address'
	extend ClientAddress
	require 'reservas'
	extend Reservas
	require 'vtiger'
	extend Vtiger
	require 'stocks'
	extend Stocks
	# attr_accessible :title, :body
	def self.start()
		
		pedidos=load_orders()	    
		
		pedidos.each do |pedido|
			
			sku = pedido["sku"]
			cantidad_pedida = pedido["qty"]
			total_disponible = 0
			almacenes = {}


			#Calculamos el total disponible en bodega
			getStock(sku).each do |stock|	
				almacenId = stock["almacenId"]
				total_disponible+= stock["libre"]
			end

		  #Si hay reservas para el sku del pedido
		  if Reserva.exists?(:sku => pedido["sku"]) 
		
				reserva = Reserva.find_by_sku(pedido["sku"])
				
				
				#Si Qal es quien hace el pedido
				if pedido["rut"]== "34.242.924-1" 
					total_despachable = total_disponible
					
				#No es Qal
				else
					total_despachable = total_disponible - reserva.qty
				end

				#Si se puede satisfacer el pedido
				if cantidad_pedida*0.96 <= total_despachable
					
					if cantidad_pedida >= total_despachable
						cantidad_pedida = total_despachable
					end

					#Proceso de Despacho
					if pedido["rut"]== "34.242.924-1" 
						
						if cantidad_pedida <= reserva.qty
								reserva.qty-= cantidad_pedida
								reserva.save
							else
								reserva.qty = 0
								reserva.save
							end
					end

					almacenes.each_pair do |id,libre|	
						
						despacho = 0						
						if cantidad_pedida <= libre
							despacho = cantidad_pedida
						else
							despacho = libre
						end
						cantidad_pedida-= despacho
						despacharStock(id,sku,despacho)
						pedido.state = "despachado"

					end
				
				#Si no se puede satisfacer el pedido
				else
					pedido[:state] = "quebrado"
				end
			
			#No hay reservas para el sku pedido
			else
				#Si se puede satisfacer el pedido
				if cantidad_pedida*0.96 <= total_disponible
					
					if cantidad_pedida >= total_disponible
						cantidad_pedida = total_disponible
					end

					almacenes.each_pair do |id,libre|	
						
						despacho = 0						
						if cantidad_pedida <= libre
							despacho = cantidad_pedida
						else
							despacho = libre
						end
						cantidad_pedida-= despacho
						despacharStock(id,sku,despacho)
						pedido.state = "despachado"

					end
				
				#Si no se puede satisfacer el pedido
				else
					pedido[:state] = "quebrado"
				end
			end
		end       
	end
end