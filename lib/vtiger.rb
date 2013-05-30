
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
  :url => 'integra4.ing.puc.cl',
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
  def add_order(adate,atime,rut,addressid,odate,sku,qty,unit)
userid=32
state="Recibido"
object_map= { 'assigned_user_id'=>"#{userid}",'Estado'=>"#{state}", 'Fecha de llegada'=>"#{adate}", 'Hora de llegada'=>"#{atime}", 'Shipping Address'=>"#{addressid}", 'Due Date'=>"#{odate}"}
        self.cmd.add_object(object_map,self.options,'SalesOrder')

   end
 
end

if __FILE__ == $PROGRAM_NAME

      vtig= Vtg.new()

vtig.add_order("2005-12-02","12:00:00","17.23.22","las loicas","2013-07-18",2132323,22,"UNI4")
   
end
end