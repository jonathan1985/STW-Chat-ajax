require 'sinatra' 
require 'sinatra/reloader' if development?
#set :port, 3000
#set :environment, :production

enable :sessions
set :session_secret, '*&(^#234a)'

chat = ['Bienvenidos..']

user = Array.new()

#/************************************/

get '/' do

  if !session[:name]
	erb :login
  else
	erb :chat
  end  
end


#/************************************/

get '/chat' do  
  erb :chat  
end


#/************************************/


post '/' do
  if (user.include?(params[:username]))
	redirect '/'
  else
	name = params[:username]
	session[:name] = name
	user << name
	puts user
	erb :chat
  end
  #session[:name] = params[:username]
  #erb :index
end

#/************************************/

get '/logout' do  
  user.delete(session[:name])
  session.clear
  redirect '/'  
end


#/************************************/

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:name]} : #{params['text']}"
  nil
end


#/************************************/

get '/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []

  @last = chat.size
  erb <<-'HTML', :layout => false
      <% @updates.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
      <span data-last="<%= @last %>"></span>
  HTML
end

#/************************************/

get '/user' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @user = user
  erb <<-'HTML', :layout => false
      <% @user.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
  HTML
end

#/************************************/

