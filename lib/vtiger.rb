
module Vtiger 

require 'yaml'
require 'rubygems'
gem 'vtiger'
require 'vtiger'
require 'optparse'
require 'java' if RUBY_PLATFORM =~ /java/
require 'pp'

class Vtg
  attr_accessor :user, :key, :url, :cmd, :options

  def initialize()
  arg_hash={
  :username => 'admin',
  :key => 'Lrl63myYMRkXfwI3',
  :url => 'integra4.ing.puc.cl/vtiger',
  :help => 'true',
  
  }
  self.user= arg_hash[:username]
  self.key=arg_hash[:key]
  self.url=arg_hash[:url]
  
  self.options = arg_hash
  
  self.cmd = Vtiger::Commands.new()
  self.cmd.challenge(options)
  self.cmd.login(options)

  end
  def rut_query(rut)

              element='Accounts'
              field='cf_640'
              name=rut
       
                 puts "in query element by field #{field} #{element} name: #{name}"
                    action_string=ERB::Util.url_encode("select id,accountname from #{element} where #{field} like '#{name}';")
                    
                    res = self.cmd.http_ask_get(self.cmd.endpoint_url+"operation=query&sessionName=#{self.cmd.session_name}&query="+action_string)
                    values=res["result"][0] if res["success"]==true   #comes back as array
                    success = false
                    #puts values.inspect
                    # return the account id
                     
                     if values!= nil 
                      
                       success=true
                       object_map = {
                        'success' => success,
                        'id' => values["id"],
                    'account_name' => values["accountname"],

}
                     end
                     return  object_map
                
                end
  
  def product_query(sku)
              element='Products'
            
              field='productcode' 
              name=sku
             puts "in query element by field #{field} #{element} name: #{name}"
                    action_string=ERB::Util.url_encode("select id,productname,cf_641,cf_642,cf_643 from #{element} where #{field} like '#{name}';")
                    res = self.cmd.http_ask_get(self.cmd.endpoint_url+"operation=query&sessionName=#{self.cmd.session_name}&query="+action_string)
                    values=res["result"][0] if res["success"]==true   #comes back as array
                    success = true
                  
                     object_map = {
                        'success' => success,
                        'id' => values["id"],
                    'product_name' => values["productname"],
                    'marca' => values["cf_643"],
                    'tipo' => values["cf_642"],
                    'fundo' => values["cf_641"],

}
                     return  object_map
               puts "Consulta realizada"
  end  
   def order_id_query(order_id)
              element='SalesOrder'
            
              field='cf_653' 
              name=order_id
             puts "in query element by field #{field} #{element} name: #{name}"
                    action_string=ERB::Util.url_encode("select id from #{element} where #{field} like '#{name}';")
                    res = self.cmd.http_ask_get(self.cmd.endpoint_url+"operation=query&sessionName=#{self.cmd.session_name}&query="+action_string)
                    values=res["result"][0] if res["success"]==true   #comes back as array
                    success = true
                  
                     object_map = {
                        'success' => success,
                        'id' => values["id"],
                    

}
                     return  object_map
               puts "Consulta realizada"
  end  
  def add_order(order_id, adate,atime,rut,addressid,odate,sku,qty,unit)
product=self.product_query(sku)
account=self.rut_query(rut)

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

  salesid=order_id_query(order_id)
  sales_order=self.cmd.retrieve_object(salesid["id"])

  sales_order["cf_649"]=new_state
  sales_order["invoicestatus"]='Created'
  


           
            tmp=self.cmd.json_please(sales_order)
            input_array ={'operation'=>'update','sessionName'=>"#{self.cmd.session_name}", 'element'=>tmp} 
            result = self.cmd.http_crm_post("operation=update",input_array)




end


      


end
end