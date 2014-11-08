$(document).ready(function(){
  // Hide new path form on load
  $('#new-path-form-js').hide();

  // Show new path form
  $('#create-new-path-button').on('click',function(e){
    e.preventDefault();
    $('#new-path-form-js').toggle('slow');
    });

  $('#new-path-form-js form').on('submit',function(e){
    e.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "POST",
      dataType: "json",
      url: "/paths",
      data: formData ,
      success: function(data,stuff,xhr){
        $("select#skill_path_id").append("<option value="+data.id+">"+data.name+"</option>")
        $("#new-path-form-js form").prepend("<p>"+data.name+" path created : It is available in the dropdown above.</p>")
      },
      error: function(data,stuff,error){
        $("#new-path-form-js form").prepend("<p>Ooops, Something went wrong. Make sure both fields are filled out</p>");
      }
    });
  });
});
