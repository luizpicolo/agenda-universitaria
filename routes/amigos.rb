get '/amigos' do
    throw(redirect '/') unless session[:authenticated]
    @usuarios = Usuario.all()
    erb :amigos
end

get '/amigos/adicionar/:id' do
    throw(redirect '/') unless session[:authenticated]
    
    Usuario.push(
        {:_id => session[:usuario].id}, 
        :amigos => params[:id] 
    )
    
    redirect '/painel'
end

get '/amigos/remover/:id' do
    throw(redirect '/') unless session[:authenticated]
    
    Usuario.pull(
        {:_id => session[:usuario].id}, 
        :amigos => params[:id] 
    )
    
    redirect '/painel'
end