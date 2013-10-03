get '/painel' do
    erb :painel
end

get '/lembretes-form' do
	erb :'form-notas', :layout => false
end

get '/lembretes' do
	@all_lembretes = Lembrete.all
	erb :lembretes
end

post '/lembretes' do
	lembrete = Lembrete.create(:titulo => params[:titulo], :texto => params[:texto])
	lembrete.save

	redirect '/lembretes'
end

delete '/lembretes/:id' do
	#l = Lembrete.first(:id => params[:id])
	#l.destroy
	Lembrete.destroy(params[:id])

	redirect '/lembretes'
end