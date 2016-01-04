post '/signup' do
  user = User.new(params[:user])
  # user.password = params[:password]
  if user.save
    # what should happen if the user is save?
  else
    # what should happen if the user keyed in invalid date?
  end
end  