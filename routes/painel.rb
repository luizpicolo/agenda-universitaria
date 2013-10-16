get '/painel' do
    throw(redirect '/') unless session[:authenticated]
    @usuario = Usuario.first(:_id => session[:usuario]._id)
    erb :painel
end

get '/:usuario/painel' do
    throw(redirect '/') unless session[:authenticated]
    @usuario = Usuario.first(:usuario => params[:usuario])
    @vinculo = Usuario.first(:_id => session[:usuario]._id, :amigos_ids => [@usuario._id]) || false
    erb :painel_amigos
end