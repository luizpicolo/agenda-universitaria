get '/painel' do
    throw(redirect '/') unless session[:authenticated]
    @tarefas = Tarefa.all(:order => :prioridade.asc, :order => :data_inicio.asc)
    erb :painel
end