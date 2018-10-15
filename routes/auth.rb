before '/app/*' do
	# we don't need to really retrieve the user record in most cases, since we just need the ID
	if !session[:user_id]
		halt redirect '/auth/login', 303
	end
end

get '/auth/login' do
	haml :login
end

post '/auth/login' do
	user = User.where({username:params[:username]}).first
	unless user && user.check_password(params[:password])
		halt haml :cannot_login
	end

	session[:user_id] = user.id

	redirect '/app/links', 303
	return nil
end
post '/auth/register' do
	username = params[:username]
	if username.to_s == '' || User.where({username: username}).count > 0
		halt haml :unavailable_username
	end
	user = User.new
	user.username = username
	user.set_password(params[:password])
	user.save

	session[:user_id] = user.id

	redirect '/app/links', 303
	return nil
end
