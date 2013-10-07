require 'mongo_mapper'

class Tarefa
	include MongoMapper::Document
    
    key :id_usuario, String, :required => true
	key :titulo, String, :required => true
	key :data_inicio, Time, :required => true
	key :data_termino, Time
	key :data_cadastro, Time
    key :categoria, Integer
    key :descricao, String
    key :prioridade, Integer, :required => true
    key :visibilidade, Integer, :required => true
end
