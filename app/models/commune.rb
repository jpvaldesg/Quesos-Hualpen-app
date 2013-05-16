class Commune < ActiveRecord::Base

	include ClientsDatabase
	self.table_name="comunas"
	attr_accessible :id, :nombre, :region
	belongs_to :region, :foreign_key => "regionId"
	#has_many :addresses
end