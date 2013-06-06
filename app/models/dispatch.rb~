class Dispatch < ActiveRecord::Base
  attr_accessible :description, :direction, :final, :gmaps, :latitude, :longitude
  acts_as_gmappable :process_geocoding => false

  def self.date_ok
    Dispatch.find(:all, :conditions => [ "final >= ?", Date.today])
  end

end
