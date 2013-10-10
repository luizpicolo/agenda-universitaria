require 'mongo_mapper'

class Amigo
	include MongoMapper::Document
    
    key :amigo, String, :required => true 
    belongs_to :usuario
    
end
