require 'mongo'
require 'mongo_mapper'

#configuração do MongoDB
configure do
	MongoMapper.database = 'agenda'
end

require_relative 'tarefa.rb'