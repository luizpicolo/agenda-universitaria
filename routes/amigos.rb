get '/amigos' do
    throw(redirect '/') unless session[:authenticated]
    vinculo = []
    usuario = Usuario.all(:_id => session[:usuario]._id).first
    usuario.amigos.each {|usr| 
        vinculo << Usuario.where(:_id => usr).first  
    }
    @amigos = vinculo;
    erb :amigos
end

get '/amigos/:usuario/:acao/:id' do
    throw(redirect '/') unless session[:authenticated]
    
    if params[:acao] == 'adicionar'
        Usuario.push(
            {:_id => session[:usuario].id}, 
            :amigos => params[:id] 
        )
    elsif params[:acao] == 'remover'
        Usuario.pull(
            {:_id => session[:usuario].id}, 
            :amigos => params[:id] 
        )
    end
    
    redirect '/'+params[:usuario]+'/painel'
end