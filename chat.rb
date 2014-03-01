require 'sinatra' # gem install sinatra --no-rdoc --no-ri
set :port, 3000
set :environment, :production
 
html = <<-EOT
<html><head><style>
#text{width:100%; font-size: 15px; padding: 5px; display: block;}
</style></head><body>
  <input id="text" placeholder="Write then press Enter."/>
  <div id="chat"></div>
  <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
  <script>
  $('#text').keypress(function(e){
    if( e.keyCode==13 ){
      $.get('/send',{text:$('#text').val()});
      $('#text').val('');
    }
  });
  last = 0;
  setInterval(function(){
    $.get('/update',{last:last},
      function(response){
        last = $('<p>').html(response).find('span').data('last');
        $('#chat').append(response);
        });
    },1000);
  </script>
</body></html>
EOT
 
chat = ['welcome..']
get('/') { html }
get '/send' do
  chat << "#{request.ip} : #{params['text']}"
  nil
end
get '/update' do
  updates = chat[params['last'].to_i..-1]
  last = "<span data-last=\"#{chat.size}\"></span>"
  if updates.size>0
  updates.join('</br>') + "#{last}</br>"
  else
    last
  end
end
