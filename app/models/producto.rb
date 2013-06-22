class Producto < ActiveRecord::Base

  attr_accessible :descripcion, :desde, :hasta, :precio, :sku

  scope :activo, lambda {where("hasta > ? and Desde < ?",Date.today,Date.today)}

  def self.active
    Producto.find(:all, :conditions => ["hasta > ? and desde < ?", Date.today, Date.today])
  end

  def self.by_sku(sku)
    Producto.find(:all, :conditions => ["hasta > ? and desde < ? and sku = ?", Date.today, Date.today, sku]).last
  end



end
