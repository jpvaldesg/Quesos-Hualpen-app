class Order < ActiveRecord::Base
  require 'Mailer'
  require 'Reservas'
  extend Mailer
  extend Reservas
  attr_accessible :addressId, :arrivalDate, :arrivalTime, :orderDate, :qty, :rut, :sku, :state, :unit
 
  def self.process_orders
  	 load_orders()
  end

  def self.process_reserves()
  	view_reserves()
  end

end
