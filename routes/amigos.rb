get '/amigos' do
    throw(redirect '/') unless session[:authenticated]
    @usuarios = Usuario.all()
    erb :amigos
end

get '/amigos/seguir/:id' do
    throw(redirect '/') unless session[:authenticated]
    @usuarios = Usuario.all()
    redirect '/amigos'
end