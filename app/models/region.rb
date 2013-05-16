class Region < ActiveRecord::Base

	include ClientsDatabase
	self.table_name="regiones"
	attr_accessible :id, :nombre
	has_many :communes
end