get '/' do
  erb :"static/signup"
end

get '/login' do
  erb :"static/login"
end

get '/users/:id' do
end