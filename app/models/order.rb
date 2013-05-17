class Order < ActiveRecord::Base
  require 'mailer'
  require 'reservas'
  extend Mailer
  extend Reservas
  attr_accessible :addressId, :arrivalDate, :arrivalTime, :orderDate, :qty, :rut, :sku, :state, :unit
 
  def self.process_orders
  	 load_orders()
  end

  def self.process_reserves()
  	view_reserves()
  end

  def self.quebrado
    Order.find(:all, :conditions => [ "state = ?", "quebrado"])
  end

end
