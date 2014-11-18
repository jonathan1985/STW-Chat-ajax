require 'sinatra' 
require 'sinatra/reloader' if development?
require 'haml'
#set :port, 3000
#set :environment, :production

enable :sessions
set :session_secret, '*&(^#234a)'

chat = []
user = Hash.new()

get '/' do
  if !session[:name]
    haml :login
  else
    haml :chat
  end
end

get '/chat' do
  haml :chat
end

get '/reset' do
  chat = ['welcome..']
end

post '/' do
  if(user.include?(params[:username]))
    redirect '/'
  else
    name = params[:username]
    color = rand(0xffffff).to_s(16)
    session[:name] = name
    session[:color] = color
    user[name] = [name,color]
    haml :chat
  end
end
get '/logout' do
  user.delete(session[:name])
  session.clear
  redirect '/'
end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << [session[:name],session[:color],"#{params['text']}"]
  nil
end

get '/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []
  @last = chat.size
  haml :update, :layout => false
end

get '/user' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @user = user
  haml :user, :layout => false
end

get '/chat/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []

  @last = chat.size
  haml :chat_response, :layout => false
end
