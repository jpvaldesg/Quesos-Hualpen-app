class Event
  include Mongoid::Document
  field :type, type: String
  field :qty, type: BigDecimal
  field :unit, type: String
  field :rut, type: String
  field :orderId, type: Integer
  field :sku, type: String
end
