require_relative 'autenticacao'
require_relative 'painel'
require_relative 'tarefas'
require_relative 'erro'

not_found do
  redirect '/erro'
end