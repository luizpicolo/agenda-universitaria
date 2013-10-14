require 'mongo_mapper'

class Usuario
	include MongoMapper::Document
    
	key :nome, String, :required => true
    key :email, String, :required => true, :unique => true
    key :avatar, String
	key :descricao, String
    key :data_cadastro, Time
    key :usuario, String, :required => true, :unique => true
    key :senha, String, :required => true
    key :facebook, String
    key :twitter, String
    key :localidade, String
    key :amigos_ids, Array, :typecast => 'ObjectId'
    
    many :usuarios, :class_name => 'Usuario', :in => :amigos_ids
    many :tarefas
    
    def add_amigo(*amigos)
		amigos.each do |amigo|
			self.usuarios << amigo
		end
		save		
	end
    
    def rmv_amigo(*amigos)
		amigos.each do |amigo|
			self.usuarios.delete(amigo)
		end
		save		
	end
end
