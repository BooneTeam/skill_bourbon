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

    //This is now on application.js
//  // Tabs on new skill form
//  $('.accordion-tabs-minimal').each(function(index) {
//    $(this).children('li').first().children('a').addClass('is-active').next().addClass('is-open').show();
//  });
//
//  $('.accordion-tabs-minimal').on('click', 'li > a', function(event) {
//    if (!$(this).hasClass('is-active')) {
//      event.preventDefault();
//      var accordionTabs = $(this).closest('.accordion-tabs-minimal');
//      accordionTabs.find('.is-open').removeClass('is-open').hide();
//
//      $(this).next().toggleClass('is-open').toggle();
//      accordionTabs.find('.is-active').removeClass('is-active');
//      $(this).addClass('is-active');
//    } else {
//      event.preventDefault();
//    }
//  });

});
