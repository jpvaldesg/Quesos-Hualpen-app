
module vtiger

   def cargar_contacto(object_map)
    # Object_map debe ser el hash del pedido
	require 'vtiger'
	Vtiger::Api.api_settings = {
     :username => 'admin',
     :key => 'grupo4',
     :url => 'integra4.ing.puc.cl',
    }
 	#cmd = Vtiger::Commands.new()
 	#challenge=cmd.challenge({})
 	#login=cmd.login({})

   arg_hash=Vtiger::Options.parse_options(ARGV)
   Vtiger::Options.show_usage_exit(usage) if arg_hash[:help]==true
   require 'pp'
  options = arg_hash
   # set up variables using hash
     
    cmd = Vtiger::Commands.new()
    cmd.challenge(options)
    cmd.login(options)
        

    add_object(object_map,options,'OrderSales')
	end
end