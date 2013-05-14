require 'Mailer'
require 'Reservas'
class Order < ActiveRecord::Base
  extend Mailer
  extend Reservas
  attr_accessible :addressId, :arrivalDate, :arrivalTime, :orderDate, :qty, :rut, :sku, :state, :unit
 
  def self.read_orders
  	 load_orders()
  end

  def self.ver_reservas()
  	read()
  end

end
