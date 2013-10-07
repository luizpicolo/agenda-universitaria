require 'mongo_mapper'

class Amigo
	include MongoMapper::Document
    
	many :id_usuario, String, :required => true
    key :ids_amigos, Array
    many :usuarios, :in => :ids_amigos
end
