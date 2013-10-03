get '/' do
    @tarefas = Tarefa.all
    erb :painel
end

get '/painel' do
    @tarefas = Tarefa.all(:order => :prioridade.asc, :order => :data_inicio.asc)
    erb :painel
end