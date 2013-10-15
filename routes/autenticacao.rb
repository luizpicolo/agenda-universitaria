####
# Configurações para OmniAuth
####
configure do
    set :sessions, true
    set :inline_templates, true
end

####
# Provedores de acesso para autenticação
####
use OmniAuth::Builder do
    provider :facebook, '487073518057149','150eece42a816d0a88be3043cbb619d1'
    #provider :twitter, 'N9kDuhTXbWjC0wX6kmU0w', 's1d9mGBlBW8JQOYVI6NBNSjv8C7GSudRvBfvVrPWuA'
end

####
# Verifica se há a sessão de autenticação do usuario
# caso não exista, direciona o usuário para a página para que o mesmo
# se autentique. Caso exista, é direcionado para o painel principal
####
get '/' do
    if !session[:authenticated]
        erb :autenticacao, :layout => false
    else
        redirect '/painel'  
    end
end

####
# Methodo de retorno da autenticação
# Esse recebe um objeto JSON caso a autenticação seja feita 
# por algum provedor de acesso estipulado no OmniAuth::Builder
####
get '/auth/:provider/callback' do
    # Objeto JSON
    obj = JSON.parse(request.env['omniauth.auth'].to_json)
    
    # Salva o usuario caso não exista
    time = Time.new
    if params[:provider] == 'facebook'
        Usuario.create(
            :nome => obj['info']['name'],
            :email => obj['info']['email'],
            :avatar => obj['info']['image'],
            :descricao => obj['info']['description'],
            :data_cadastro => time.getlocal,
            :usuario => obj['info']['nickname'],
            :senha => SecureRandom.hex,
            :facebook => obj['info']['urls']['facebook'],
            :localidade => obj['info']['location'],
        ).save()
#    elsif params[:provider] == 'twitter'        
#        Usuario.create(
#            :nome => obj['info']['name'],
#            :email => obj['info']['email'] || 'mail@provedor.com',
#            :avatar => obj['info']['image'],
#            :descricao => obj['info']['description'],
#            :data_cadastro => time.getlocal,
#            :usuario => obj['info']['nickname'],
#            :senha => SecureRandom.hex,
#            :localidade => obj['info']['location']  
#        ).save()  
#    else
#        "teste"
    end
    
    # Seleciona o usuário corrente
    usuario = Usuario.first(:usuario => obj['info']['nickname'])
    
    # cria a sessão para o usuário logado
    session[:authenticated] = true
    
    # Dados do usuário armazenados em uam sessão para
    # posterior acesso
    session[:usuario] = usuario
    
    redirect "/painel"
end

####
# Methodo para autenticação local
# sem utilização de provedores externos
####
post '/auth/:provider/callback' do
    
    # Seleciona o usuário corrente
    ############# UTILIZAR GRIPTOGRAFIA
    usuario = Usuario.first(:usuario => params[:usuario], :senha => params[:senha]) || false
    
    if usuario != false
        # cria a sessão para o usuário logado
        session[:authenticated] = true
        session[:usuario] = usuario
        
        redirect "/painel"
    else
        flash_messenger('Usuário não Cadastrado', 'error')
        #session[:msg_erro] = alert_error('Usuário não cadastrado')
        redirect "/"
    end     
end

####
# Methodo que redireciona o usuário caso haja um erro
####
get '/auth/failure' do
    redirect "/"
end
  
####
# Methodo que redireciona o usuário caso haja um erro
# de desautorização
####
get '/auth/:provider/deauthorized' do
    redirect "/"
end

####
# Methodo para deslogar o usuário
####
get '/logout' do
    flash_messenger('Deslogado com Sucesso', 'success')
    session[:authenticated] = false
    redirect '/'
end