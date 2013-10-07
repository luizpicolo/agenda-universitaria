configure do
    set :sessions, true
    set :inline_templates, true
end

use OmniAuth::Builder do
    provider :facebook, '487073518057149','150eece42a816d0a88be3043cbb619d1'
    provider :twitter, 'N9kDuhTXbWjC0wX6kmU0w', 's1d9mGBlBW8JQOYVI6NBNSjv8C7GSudRvBfvVrPWuA'
end

get '/' do
    if !session[:authenticated]
        erb :autenticacao, :layout => false
    else
        redirect "/painel"  
    end
end

get '/auth/:provider/callback' do
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
            :localizada => obj['info']['location'] 
        ).save()
    elsif params[:provider] == 'twitter'        
        Usuario.create(
            :nome => obj['info']['name'],
            :email => obj['info']['email'] || 'mail@provedor.com',
            :avatar => obj['info']['image'],
            :descricao => obj['info']['description'],
            :data_cadastro => time.getlocal,
            :usuario => obj['info']['nickname'],
            :senha => SecureRandom.hex,
            :localizada => obj['info']['location']  
        ).save()  
    else
        "teste"
    end
    
    # Seleciona o usuário corrente
    usuario = Usuario.where(:usuario => obj['info']['nickname']).first
    
    # cria a sessão para o usuário logado
    session[:authenticated] = true
    session[:nome] = usuario.nome
    session[:id] = usuario._id
    session[:usuario] = usuario.usuario
    session[:avatar] = usuario.avatar
    
    redirect "/painel"
end

get '/auth/failure' do
    erb "<h1>Erro ao autenticar:</h1><h3>Mensagem:<h3> <pre>#{params}</pre>"
end
  
get '/auth/:provider/deauthorized' do
    erb "#{params[:provider]} desautorizou seu app."
end
    
get '/logout' do
    session[:authenticated] = false
    redirect '/'
end