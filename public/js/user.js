(function() {
  setInterval(
    function(){
      $.get('/user',
        function(response){
          $('#user').replaceWith(response);
        }
      );
    },
  1000);
})();