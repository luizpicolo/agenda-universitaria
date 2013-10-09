get '/amigos' do
    throw(redirect '/') unless session[:authenticated]
    @usuarios = Usuario.all()
    erb :amigos
end

get '/amigos/:usuario/:acao/:id' do
    throw(redirect '/') unless session[:authenticated]
    
    if params[:acao] == 'adicionar'
        Usuario.push(
            {:_id => session[:usuario].id}, 
            :amigos => params[:id] 
        )
    else if params[:acao] == 'remover'
        Usuario.pull(
            {:_id => session[:usuario].id}, 
            :amigos => params[:id] 
        )
    end
    
    redirect '/'+params[:usuario]+'/painel'
end