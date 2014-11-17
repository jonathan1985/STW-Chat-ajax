require 'sinatra' 
require 'sinatra/reloader' if development?
#set :port, 3000
#set :environment, :production

enable :sessions
set :session_secret, '*&(^#234a)'

chat = ['welcome..']
user = Array.new()

get '/' do
  if !session[:name]
    erb :login
  else
    erb :chat
  end
end

get '/chat' do
  erb :chat
end

post '/' do
  if(user.include?(params[:username]))
    redirect '/'
  else
    name = params[:username]
    session[:name] = name
    user << name
    puts user
    erb :chat
  end
end
get '/logout' do
  user.delete(session[:name])
  session.clear
  redirect '/'
end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:name]} : #{params['text']}"
  nil
end

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
get '/user' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @user = user
  erb <<-'HTML', :layout => false
    <div id="user">
      <% @user.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
    </div>
  HTML
end
get '/chat/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []
  @last = chat.size
  erb <<-'HTML', :layout => false
      <% @updates.each do |phrase| %>
          <ul class="chat">
            <li class="left clearfix"><span class="chat-img pull-left">
                <img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />
            </span>
                <div class="chat-body clearfix">
                    <div class="header">
                        <strong class="primary-font">Jack Sparrow</strong> <small class="pull-right text-muted">
                            <span class="glyphicon glyphicon-time"></span>12 mins ago</small>
                    </div>
                    <p>
                        <%= phrase %> <br />
                    </p>
                </div>
            </li>
        </ul>
      <% end %>
      <span id="last" data-last="<%= @last %>"></span>
  HTML
end
