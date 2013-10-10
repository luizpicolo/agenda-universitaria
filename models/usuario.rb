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
    key :localizada, String
    
    many :amigos
    many :tarefas
end
