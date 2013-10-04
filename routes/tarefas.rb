get '/tarefas' do
    erb :tarefas
end

post '/tarefas' do
  time = Time.new
  tarefa = Tarefa.create(
                :titulo => params[:titulo], 
                :data_inicio => params[:data_inicio], 
                :data_termino => params[:data_termino], 
                :data_cadastro => time.getlocal,
                :categoria => params[:categoria],
                :descricao => params[:descricao], 
                :prioridade => params[:prioridade],
                :visibilidade => params[:visibilidade]
            )
  tarefa.save()
end

put '/tarefas' do
    Tarefa.set(
        {:_id => params[:id]},
        :titulo => params[:titulo], 
        :data_inicio => params[:data_inicio], 
        :data_termino => params[:data_termino], 
        :categoria => params[:categoria],
        :descricao => params[:descricao], 
        :prioridade => params[:prioridade],
        :visibilidade => params[:visibilidade]
    )
end

get '/tarefas/get_array_json' do
    array = []
    tarefas = Tarefa.all
    tarefas.each do |tarefa|
    array << {  
            :_id => tarefa._id, 
            :start => tarefa.data_inicio, 
            :end => tarefa.data_termino, 
            :title => tarefa.titulo,
            :url => 'javascript:getModalEdit("'+tarefa._id+'")'
        }
    end 
    json(array)
end

get '/tarefas/get_tarefa/:id' do
    tarefa = Tarefa.find(params[:id]) 
    json({  
            :id => tarefa._id, 
            :data_inicio => tarefa.data_inicio.strftime("%d/%m/%Y"), 
            :data_termino => tarefa.data_termino.strftime("%d/%m/%Y"), 
            :titulo => tarefa.titulo,
            :categoria => tarefa.categoria,
            :prioridade => tarefa.prioridade,
            :visibiliade => tarefa.visibilidade,
            :descricao => tarefa.descricao
        })
end

get '/tarefas/cadastro' do
    erb :cadastro_tarefas, :layout => false
end