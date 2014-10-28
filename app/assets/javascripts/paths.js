$(document).ready(function(){

  $('#new-path-form-js').hide();

  $('#create-new-path-button').on('click',function(e){
    e.preventDefault();
    $('#new-path-form-js').toggle('slow');
    })
});
