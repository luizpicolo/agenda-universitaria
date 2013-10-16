get '/configuracoes' do
    
    # Retorna os dados do usuário
    @geral = Usuario.first(:_id => session[:usuario]._id)
    erb :configuracoes
end

# Método para atualizar as configuracoes
put '/configuracoes' do
    
    if params[:nova_senha] != ''
        if params[:nova_senha] != params[:digite_novamente]
            alert_error("Suas senhas não conferem.")
        elsif  
            Usuario.set(
                {:_id => session[:usuario]._id},
                :nome => params[:nome], 
                :senha => params[:digite_novamente], 
                :email => params[:email], 
                :descricao => params[:descricao] 
            )
            alert_success("Configurações atualizadas com sucesso")
        end
    elsif 
        Usuario.set(
            {:_id => session[:usuario]._id},
            :nome => params[:nome], 
            :email => params[:email], 
            :descricao => params[:descricao] 
        )
        alert_success("Configurações atualizadas com sucesso")
    end
end