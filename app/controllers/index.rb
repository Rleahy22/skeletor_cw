get '/' do

	erb :index
end

post '/user' do
	@user = User.verify(params)
	unless @user.nil?
		session[:auth] = @user.id
		redirect "user/#{@user.id}"
	else
		redirect '/login'
	end
end

get '/signup' do

	erb :signup
end

post '/create_user' do
	@user = User.create(params[:user])
	session[:auth] = @user.id
	redirect "/user/#{@user.id}"
end

get '/user/:id' do
	redirect '/' unless session[:auth] == params[:id].to_i
	@user = User.find(session[:auth])

	erb :user
end

get '/logout' do
	session[:auth] = nil
	redirect '/'
end

get '/photos' do
	@user = User.find(session[:auth])

	erb :photos
end

post '/photos' do
	Image.create(params[:photo])
	redirect '/photos'
end
