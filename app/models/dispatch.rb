class Dispatch < ActiveRecord::Base
  attr_accessible :description, :direction, :final, :gmaps, :latitude, :longitude
  acts_as_gmappable :process_geocoding => false, :validation => false

  def self.date_ok
    Dispatch.find(:all, :conditions => [ "final >= ?", Date.today])
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |dispatch|
        csv << dispatch.attributes.values_at(*column_names)
      end
    end
  end

end
