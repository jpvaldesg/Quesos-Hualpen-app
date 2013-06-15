module salesforceCRM

	#Login a Sales force
	def getClient 
		client = Databasedotcom::Client.new :client_id => "005i0000000P1cn", :client_secret => "bob" :host => "www.salesforce.com"
		client.authenticate :username => "quesoshualpentest@gmail.com", :password => "quesos123"  #=> "the-oauth-token"
		
		#retona lista de objetos de saleforce
		client.list_sobjects
		#materializar un objeto
		contact_class = client.materialize("Contact")

		contact = Contact.find("contact_id")                #=> #<Contact @Id="contact_id", ...>
		contact = Contact.find_by_Name("John Smith")        #=> dynamic finders!
		contacts = Contact.all                              #=> a Databasedotcom::Collection of Contact instances
		contacts = Contact.find_all_by_Company("IBM")       #=> a Databasedotcom::Collection of matching Contacts
		contact.Name                                        #=> the contact's Name attribute
		contact["Name"]                                     #=> same thing
		contact.Name = "new name"                           #=> change the contact's Name attribute, in memory
		contact["Name"] = "new name"                        #=> same thing
		contact.save                                        #=> save the changes to the database
		contact.update_attributes "Name" => "newer name",
		  "Phone" => "4156543210"                           #=> change several attributes at once and save them
		contact.delete                                      #=> delete the contact from the database

	end



end