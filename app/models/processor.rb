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
		        if stock["libre"] > 0
					almacenes[almacenId] = stock["libre"]
		        end
			end

		  #Si hay reservas para el sku del pedido
		  if Reserva.exists?(:sku => pedido["sku"]) and Reserva.find_by_sku(pedido["sku"]).qty > 0 
			
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

		      cantidad_final_despacho = cantidad_pedida
          almacenes.each_pair do |id,libre|
		            if cantidad_pedida == 0
		                break
		            end
		            despacho = 0
		            if cantidad_pedida <= libre
		              despacho = cantidad_pedida
		            else
		              despacho = libre
		            end
		            cantidad_pedida-= despacho
		            if id != "102"
		              if id != 45
		                moverStock(id,"102",sku, despacho)
		              else
		                moverStock(id,"55",sku, despacho)
		                moverStock("55","102",sku, despacho)
		              end
		            end

		          end

		          despacharStock("102",sku,cantidad_final_despacho)
		          pedido[:state] = "despachado"
		          pedido.save
				
				#Si no se puede satisfacer el pedido
				else
					pedido[:state] = "quebrado"
					pedido.save
				end
			
			#No hay reservas para el sku pedido
			else
				#Si se puede satisfacer el pedido
				if cantidad_pedida*0.96 <= total_disponible
					
					if cantidad_pedida >= total_disponible
						cantidad_pedida = total_disponible
					end

          cantidad_final_despacho = cantidad_pedida
          almacenes.each_pair do |id,libre|

            despacho = 0
            if cantidad_pedida == 0
              break
            end

						if cantidad_pedida <= libre
							despacho = cantidad_pedida
						else
							despacho = libre
						end
						cantidad_pedida-= despacho
						if id != "102"
							if id != 45
								moverStock(id,"102",sku, despacho)
							else
								moverStock(id,"55",sku, despacho)
								moverStock("55","102",sku, despacho)
							end
						end

          end

          despacharStock("102",sku,cantidad_final_despacho)
          pedido[:state] = "despachado"
          pedido.save
				
				#Si no se puede satisfacer el pedido
				else
					pedido[:state] = "quebrado"
					pedido.save
				end
			end
		end       
	end
end