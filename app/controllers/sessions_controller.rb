enable :sessions

post '/login' do
  # apply a authentication method to check if a user has entered a valid email and password
  # if a user has successfully been authenticated, you can assign the current user id to a session
 if (user = User.authenticate(params[:user][:email], params[:user][:password]))
    session["user_id"] ||= user.id
    session["email"] ||= user.email
  erb :"static/authenticated"
  else
    # redirect_to home_url
  end
end

post '/logout' do
  # kill a session when a user choses to logout, for example assign nil to a session
  # redirect to the appropriate page
  session["user_id"] = nil
  session["email"] = nil
    redirect '/'
end


get '/success' do
	user = User.find_by_id(session['user_id'])
	if user
		"success"
	else
		redirect '/'
	end
end