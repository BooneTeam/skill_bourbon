$(document).ready(function(){
  // Hide new path form on load
  $('#new-path-form-js').hide();

  // Show new path form
  $('#create-new-path-button').on('click',function(e){
    e.preventDefault();
    $('#new-path-form-js').toggle('slow');
    });
});
