require 'mongo_mapper'

class Tarefa
	include MongoMapper::Document
    
	key :titulo, String, :required => true
	key :data_inicio, Time, :required => true
	key :data_termino, Time, :required => true 
	key :data_cadastro, Time, :required => true
    key :categoria, Integer
    key :descricao, String
    key :prioridade, Integer, :required => true
    key :visibilidade, Integer, :required => true
end
