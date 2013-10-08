get '/painel' do
    throw(redirect '/') unless session[:authenticated]
    @usuario = Usuario.all(:_id => session[:id]).first
    @tarefas = Tarefa.all(:id_usuario => session[:id].to_s, :order => :prioridade.asc, :order => :data_inicio.asc)
    erb :painel
end

get '/:usuario/painel' do
    throw(redirect '/') unless session[:authenticated]
    @usuario = Usuario.all(:usuario => params[:usuario]).first
    @tarefas = Tarefa.all(:id_usuario => @usuario._id.to_s, :visibilidade => 1, :order => :prioridade.asc, :order => :data_inicio.asc)
    erb :painel
end