module ClientsDatabase  
  extend ActiveSupport::Concern
  included do
    establish_connection "clients_#{Rails.env}"
  end 
end