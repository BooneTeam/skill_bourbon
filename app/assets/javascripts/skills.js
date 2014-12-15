//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){

// Hide the two forms until button is clicked
  $('#new_apprenticeship_false').hide();
  $('#new_apprenticeship_true').hide();

  $('#same-request-button').on('click',function(){
    $('#new_apprenticeship_false').slideToggle();
  });

  $('#similar-request-button').on('click',function(){
    $('#new_apprenticeship_true').slideToggle();
  });

// Render datetime picker for meeting dates
  $('.datepicker').datetimepicker();

// Watch for empty fields if user has clicked inside
// field and then clicked off without filling in
  $('input.required').on("blur",function(){
    if ($(this).val() === ""){
      if ($(this).parent().find('.error').length <= 0 ){
        $(this).parent().append("<p class='error'>This cannot be blank</p>");
      }
    }
  });

// ?
  $(".simple_form #autocomplete").on('change',function(){
    if ($(this).val() == ''){
      var inputs = $('.simple_form.search').find('input.location');
      $(inputs).each(function(){
        $(this).val('');
      });
    }
  });

//  Show tooltips on mousedown of input
  $(".tooltip2").hide();
  $(".tooltip2-item").on('mousedown',function(){
      $(".tooltip2").hide();
      var tipId = $(this).data('tip-id');
      $('#'+tipId).toggle();
  })



});
