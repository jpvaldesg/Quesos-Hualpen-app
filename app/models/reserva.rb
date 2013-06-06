class Reserva < ActiveRecord::Base
  attr_accessible :qty, :sku

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |reserva|
        csv << reserva.attributes.values_at(*column_names)
      end
    end
  end

end
