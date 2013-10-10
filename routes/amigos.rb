get '/amigos' do
    throw(redirect '/') unless session[:authenticated]
    
    @amigos = Amigo.all();
    
    erb :amigos
end

get '/amigos/:usuario/:acao/:id' do
    throw(redirect '/') unless session[:authenticated]
    
    if params[:acao] == 'adicionar'
        Amigo.create(
            :usuario => session[:usuario]._id, 
            :amigo => params[:id]
        ).save()
    elsif params[:acao] == 'remover'
        Amigo.destroy(:usuario => session[:usuario]._id.to_s, :amigo => params[:id].to_s)
    end
    
    redirect '/'+params[:usuario]+'/painel'
end