get '/configuracoes' do
    
    # Retorna os dados do usuário
    @geral = Usuario.all(:_id => session[:id]).first
    erb :configuracoes
end

# Método para atualizar as configuracoes
put '/configuracoes' do
    Usuario.set(
        {:_id => session[:id]},
        :nome => params[:nome], 
        #:usuario => params[:usuario], 
        :email => params[:email], 
        :descricao => params[:descricao] 
    )
    "Sucesso"
end