require 'sinatra' 
require 'sinatra/reloader' if development?
#require 'erb'
#set :port, 3000
#set :environment, :production

chat = ['welcome..']

get('/') { erb :index }

get '/send' do
  puts "send ...."
  p params
  chat << "#{request.ip} : #{params['text']}"
  p chat
  nil
end

get '/update' do
  puts "update ***************"
  p params
  updates = chat[params['last'].to_i..-1]
  last = %Q{<span data-last="#{chat.size}"></span>}
  if updates && updates.size>0
    puts "/update"
    p updates
    #response = updates.join('</br>') + "#{last}</br>"

    response = erb <<-'HTML', :locals => {:updates => updates, :last =>last } #, 0, '>' # trim mode
        <% updates.each do |phrase| %>
          <%= phrase %> <br />
        <% end %>
        <%= last %>
    HTML
    #response = template.result(binding())

    puts response
    response
  else
    last
  end
end
