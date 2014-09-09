//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){
  $('#new_apprenticeship_false').hide();
  $('#new_apprenticeship_true').hide();
  $('#same-request-button').on('click',function(){
    $('#new_apprenticeship_false').slideToggle();
  });

  $('#similar-request-button').on('click',function(){
    $('#new_apprenticeship_true').slideToggle();
  });

  $('.datepicker').datetimepicker();
});
