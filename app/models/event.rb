class Event
  include Mongoid::Document
  include Mongoid::Timestamps::Created

#Ejemplo de registro de eventos:
#Event.create(type: "recibido", qty: 1, unit: "UN", rut: "1233-2", orderId: 1232445, sku: "2343455")


  field :type, type: String
  field :qty, type: BigDecimal
  field :unit, type: String
  field :rut, type: String
  field :orderId, type: Integer
  field :sku, type: String
  validates :type, :presence => true
  validates :rut, :presence => true
  validates :orderId, :presence => true
  validates :sku, :presence => true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << fields.collect { |field| field[0] }
      all.each do |event|
        csv << event.attributes.values_at(*fields.collect { |field| field[0] })
      end
    end
  end

end
