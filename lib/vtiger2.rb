module Vtiger2 


  def add_order(order_id, adate,atime,rut,addressid,odate,sku,qty,unit)
require 'yaml'
require 'rubygems'
gem 'vtiger'
require 'vtiger'
require 'optparse'
require 'java' if RUBY_PLATFORM =~ /java/
require 'pp'
arg_hash={
  :username => 'admin',
  :key => 'Lrl63myYMRkXfwI3',
  :url => 'integra4.ing.puc.cl/vtiger',
  :help => 'true',
  
  }
  user= arg_hash[:username]
  key=arg_hash[:key]
  url=arg_hash[:url]
  
  options = arg_hash
  
  cmd = Vtiger::Commands.new()
  cmd.challenge(options)
  cmd.login(options)

 element='Products'
            
              field='productcode' 
              name=sku
             #puts "in query element by field #{field} #{element} name: #{name}"
                    action_string=ERB::Util.url_encode("select id,productname,cf_641,cf_642,cf_643 from #{element} where #{field} like '#{name}';")
                    res = cmd.http_ask_get(cmd.endpoint_url+"operation=query&sessionName=#{cmd.session_name}&query="+action_string)
                    values=res["result"][0] if res["success"]==true   #comes back as array
                    success = true
                  
                     product = {
                        'success' => success,
                        'id' => values["id"],
                    'product_name' => values["productname"],
                    'marca' => values["cf_643"],
                    'tipo' => values["cf_642"],
                    'fundo' => values["cf_641"],

}
           



    element='Accounts'
              field='cf_640'
              name=rut
       
                 #puts "in query element by field #{field} #{element} name: #{name}"
                    action_string=ERB::Util.url_encode("select id,accountname from #{element} where #{field} like '#{name}';")
                    
                    res = cmd.http_ask_get(cmd.endpoint_url+"operation=query&sessionName=#{cmd.session_name}&query="+action_string)
                    values=res["result"][0] if res["success"]==true   #comes back as array
                    success = false
                    #puts values.inspect
                    # return the account id
                     
                     if values!= nil 
                      
                       success=true
                        account = {
                        'success' => success,
                        'id' => values["id"],
                    'account_name' => values["accountname"],

}
                     end
                 

subject = "Pedido de " + product["product_name"]
description = "Pedido de " + qty.to_s + " " +unit.to_s+ " de producto sku: " + sku.to_s + "\n" + "Tipo : " + product["tipo"] + "\n" + "Marca : " + product["marca"] + "\n" + "Fundo : " + product["fundo"]
object_map = {
'subject' => subject,
'description' => description,
'account_id' => account["id"],
'invoicestatus' => 'Created',
'assigned_user_id' => "19x1",
'duedate' => odate,
'ship_street'=> addressid,
'cf_647'=> adate,
'cf_648'=> atime,
'cf_649'=> 'Recibido',
'cf_653'=> order_id
}

hashv = {}
resp = cmd.add_object(  object_map , hashv , "SalesOrder" )
status = resp[0]
obj_id = resp[1]
if status
return obj_id
else
return nil
end
  
end
  def update_order(order_id,new_state)

require 'yaml'
require 'rubygems'
gem 'vtiger'
require 'vtiger'
require 'optparse'
require 'java' if RUBY_PLATFORM =~ /java/
require 'pp'

arg_hash={
  :username => 'admin',
  :key => 'Lrl63myYMRkXfwI3',
  :url => 'integra4.ing.puc.cl/vtiger',
  :help => 'true',
  
  }
  user= arg_hash[:username]
  key=arg_hash[:key]
  url=arg_hash[:url]
  
  options = arg_hash
  
  cmd = Vtiger::Commands.new()
  cmd.challenge(options)
  cmd.login(options)


      element='SalesOrder'
            
              field='cf_653' 
              name=order_id
             puts "in query element by field #{field} #{element} name: #{name}"
                    action_string=ERB::Util.url_encode("select id from #{element} where #{field} like '#{name}';")
                    res = cmd.http_ask_get(cmd.endpoint_url+"operation=query&sessionName=#{cmd.session_name}&query="+action_string)
                    values=res["result"][0] if res["success"]==true   #comes back as array
                    success = true
                  
                     salesid = {
                        'success' => success,
                        'id' => values["id"],
                    

}

  
  sales_order=cmd.retrieve_object(salesid["id"])

  sales_order["cf_649"]=new_state
  sales_order["invoicestatus"]='Created'
  


           
            tmp=cmd.json_please(sales_order)
            input_array ={'operation'=>'update','sessionName'=>"#{cmd.session_name}", 'element'=>tmp} 
            result = cmd.http_crm_post("operation=update",input_array)




end


      


end
end