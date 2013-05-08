class Order < ActiveRecord::Base
  attr_accessible :addressId, :arrivalDate, :arrivalTime, :orderDate, :qty, :rut, :sku, :state, :unit
end
