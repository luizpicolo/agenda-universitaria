require 'mongo'
require 'mongo_mapper'

#configuração do MongoDB
configure do
	MongoMapper.database = 'agenda'
end

require_relative 'tarefa.rb'
require_relative 'usuario.rb'
require_relative 'amigo.rb'