// # Place/ all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  $('#dash-new-skill-btn').on('click',function(e){
    // e.preventDefault();
    // $('.main-dash #selected_content').html('<p>Form Yay</p>');
  });

  $(".title .fa-chevron-down").on("click",function(){
    $(this).find(".toggled-content").toggle("slow");
  });

  // $('button#confirm-skill-request').on('click',function(e){
    // e.preventDefault();
    // var id = $(this).data("id");
    // $.ajax({
      // type: "POST",
      // url: "/skill_requests/"+id+"/check_accepted_status",
      // data: { id: "John", location: "Boston" },
      // success: function(data,stuff,error){
        // debugger;
      // }
    // });
  // });

});

