configure do
    set :sessions, true
    set :inline_templates, true
end

use OmniAuth::Builder do
    provider :facebook, '487073518057149','150eece42a816d0a88be3043cbb619d1'
    provider :twitter, 'N9kDuhTXbWjC0wX6kmU0w', 's1d9mGBlBW8JQOYVI6NBNSjv8C7GSudRvBfvVrPWuA'
end

get '/' do
    erb :autenticacao, :layout => false
end

get '/auth/:provider/callback' do
    erb "<h1>#{params[:provider]}</h1>
         <pre>#{request.env['omniauth.auth'].to_json}</pre>"
    session[:authenticated] = true;
    redirect '/painel'
end

get '/auth/failure' do
    erb "<h1>Authentication Failed:</h1><h3>message:<h3> <pre>#{params}</pre>"
end
  
get '/auth/:provider/deauthorized' do
    erb "#{params[:provider]} has deauthorized this app."
end
    
get '/logout' do
    session[:authenticated] = false
    redirect '/'
end