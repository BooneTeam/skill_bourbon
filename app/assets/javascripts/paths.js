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

  $(".js-vertical-tab-content").hide();
$(".js-vertical-tab-content:first").show();

/* if in tab mode */
$(".js-vertical-tab").click(function(event) {
  event.preventDefault();

  $(".js-vertical-tab-content").hide();
  var activeTab = $(this).attr("rel");
  $("#"+activeTab).show();

  $(".js-vertical-tab").removeClass("is-active");
  $(this).addClass("is-active");

  $(".js-vertical-tab-accordion-heading").removeClass("is-active");
  $(".js-vertical-tab-accordion-heading[rel^='"+activeTab+"']").addClass("is-active");
});

/* if in accordion mode */
$(".js-vertical-tab-accordion-heading").click(function(event) {
  event.preventDefault();

  $(".js-vertical-tab-content").hide();
  var accordion_activeTab = $(this).attr("rel");
  $("#"+accordion_activeTab).show();

  $(".js-vertical-tab-accordion-heading").removeClass("is-active");
  $(this).addClass("is-active");

  $(".js-vertical-tab").removeClass("is-active");
  $(".js-vertical-tab[rel^='"+accordion_activeTab+"']").addClass("is-active");
});

});
