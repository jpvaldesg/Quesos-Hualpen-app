class Address < ActiveRecord::Base

	include ClientsDatabase
	self.table_name="direcciones"
	attr_accessible :id, :rs, :direccion, :num, :depto, :otros
	has_one :commune, :foreign_key => "comunaId"
	#has_one :region, :foreign_key => "regionId"
end