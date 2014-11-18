$('#text').keypress(
  function(e){
    if( e.keyCode==13 ){
      $.get('/send',{text:$('#text').val()});
      $('#text').val('');
    } 
  }
);

(function() {
  var last = 0;
  setInterval(
    function(){
      $.get('/chat/update',{last:last},
        function(response){
          last = $($.parseHTML(response)).filter("#last").data('last');
          $('#chat').append(response);
        }
      );
    },
  1000);
})();