get '/amigos' do
    throw(redirect '/') unless session[:authenticated]
    @usuario = Usuario.first(:_id => session[:usuario]._id);
    erb :amigos
end

get '/amigos/:usuario/:acao/:id' do
    throw(redirect '/') unless session[:authenticated]
    
    usuario = Usuario.first(:_id => session[:usuario]._id)
    
    if params[:acao] == 'adicionar'
        
        amigo = Usuario.first(:_id => params[:id])
        usuario.add_amigo(amigo)
        
    elsif params[:acao] == 'remover'
        
        amigo = Usuario.first(:_id => params[:id])
        usuario.rmv_amigo(amigo)
        
    end
    
    redirect '/'+params[:usuario]+'/painel'
    
end