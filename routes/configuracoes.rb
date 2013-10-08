get '/configuracoes' do
    
    # Retorna os dados do usuário
    @geral = Usuario.all(:_id => session[:usuario].id).first
    erb :configuracoes
end

# Método para atualizar as configuracoes
put '/configuracoes' do
    Usuario.set(
        {:_id => session[:usuario].id},
        :nome => params[:nome], 
        #:usuario => params[:usuario], 
        :email => params[:email], 
        :descricao => params[:descricao] 
    )
    "Sucesso"
end