require 'mongo'
require 'mongo_mapper'

#configuração do MongoDB
configure do
	#MongoMapper.database = 'agenda'

	# Conexão com Heroku
	if ENV['MONGOLAB_URI']
    	uri = URI.parse(ENV['MONGOLAB_URI'])
    	MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
    	MongoMapper.database = uri.path.gsub(/^\//, '')
    	puts ">> db is #{uri.path.gsub(/^\//, '')}"
  	end
end

require_relative 'tarefa.rb'
require_relative 'usuario.rb'
