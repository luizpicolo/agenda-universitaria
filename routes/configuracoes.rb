get '/configuracoes' do
    
    # Retorna os dados do usuário
    @geral = Usuario.first(:_id => session[:usuario].id)
    erb :configuracoes
end

# Método para atualizar as configuracoes
put '/configuracoes' do
    
    if params[:senha_atual]
        Usuario.first(:_id => session[:usuario]._id, )
    
    Usuario.set(
        {:_id => session[:usuario]._id},
        :nome => params[:nome], 
        #:usuario => params[:usuario], 
        :email => params[:email], 
        :descricao => params[:descricao] 
    )
    "Sucesso"
end