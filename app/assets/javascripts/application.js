// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
// Removed Turbolinks because of issues.
//= require jquery
//= require jquery_ujs
//= require moment
//= require bootstrap-datetimepicker
//= require select2
//= require pickers
//= require_tree .


$(document).ready(function() {


initialize();

var placeSearch, autocomplete;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initialize() {
  // Create the autocomplete object, restricting the search
  // to geographical location types.
  autocomplete = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */(document.getElementById('autocomplete')),
      { types: ['geocode'] });
  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    fillInAddress();
  });
}

// [START region_fillform]
function fillInAddress() {
  // Get the place details from the autocomplete object.
  var place = autocomplete.getPlace();

  for (var component in componentForm) {
    $("form ."+component).value = '';
    $("form ."+component).disabled = false;
  }

  // Get each component of the address from the place details
  // and fill the corresponding field on the form.
  var fullAddress = ""
  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];
    // if (componentForm[addressType]) {
      if (addressType === "route" || addressType === "street_number" ){
        fullAddress += place.address_components[i][componentForm[addressType]] + " ";
        $("form ."+addressType).val(fullAddress);
      }
      else{
        var val = place.address_components[i][componentForm[addressType]];
        $("form ."+addressType).val(val);
      }
    // }
  }
}
// [END region_fillform]

// [START region_geolocation]
// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  }
}
// [END region_geolocation]

  var menu = $('.centered-navigation-menu');
  var menuToggle = $('.centered-navigation-menu-button');
  var signUp = $('.sign-up');

  $(menuToggle).on('click', function(e) {
    e.preventDefault();
    menu.slideToggle(function(){
      if(menu.is(':hidden')) {
        menu.removeAttr('style');
      }
    });
  });




 var Filter = (function() {
  function Filter(element) {
    this._element = $(element);
    this._optionsContainer = this._element.find(this.constructor.optionsContainerSelector);
  }

  Filter.selector = '.filter';
  Filter.optionsContainerSelector = '> div';
  Filter.hideOptionsClass = 'hide-options';

  Filter.enhance = function() {
    var klass = this;

    return $(klass.selector).each(function() {
      return new klass(this).enhance();
    });
  };

  Filter.prototype.enhance = function() {
    this._buildUI();
    this._bindEvents();
  };

  Filter.prototype._buildUI = function() {
    this._summaryElement = $('<label></label>').
      addClass('summary').
      attr('data-role', 'summary').
      prependTo(this._optionsContainer);

    this._clearSelectionButton = $('<button></button>').
      text('Clear').
      attr('type', 'button').
      insertAfter(this._summaryElement);

    this._optionsContainer.addClass(this.constructor.hideOptionsClass);
    this._updateSummary();
  };

  Filter.prototype._bindEvents = function() {
    var self = this;

    this._summaryElement.click(function() {
      self._toggleOptions();
    });

    this._clearSelectionButton.click(function() {
      self._clearSelection();
    });

    this._checkboxes().change(function() {
      self._updateSummary();
    });

    $('body').click(function(e) {
      var inFilter = $(e.target).closest(self.constructor.selector).length > 0;

      if (!inFilter) {
        self._allOptionsContainers().addClass(self.constructor.hideOptionsClass);
      }
    });
  };

  Filter.prototype._toggleOptions = function() {
    this._allOptionsContainers().
      not(this._optionsContainer).
      addClass(this.constructor.hideOptionsClass);

    this._optionsContainer.toggleClass(this.constructor.hideOptionsClass);
  };

  Filter.prototype._updateSummary = function() {
    var summary = '';
    var checked = this._checkboxes().filter(':checked');

    if (checked.length > 0) {
      summary = this._labelsFor(checked).join(', ');
    }

    this._summaryElement.text(summary);
  };

  Filter.prototype._clearSelection = function() {
    this._checkboxes().each(function() {
      $(this).prop('checked', false);
    });

    this._updateSummary();
  };

  Filter.prototype._checkboxes = function() {
    return this._element.find(':checkbox');
  };

  Filter.prototype._labelsFor = function(inputs) {
    return inputs.map(function() {
      var id = $(this).attr('id');
      return $("label[for='" + id + "']").text();
    }).get();
  };

  Filter.prototype._allOptionsContainers = function() {
    return $(this.constructor.selector + " " + this.constructor.optionsContainerSelector);
  };

  return Filter;
})();

$(function() {
  Filter.enhance();
});

// $(function() {
    /* Convenience for forms or links that return HTML from a remote ajax call.
    The returned markup will be inserted into the element id specified.
     */
    $('.search-tools form[data-update-target]').on('ajax:success', function(e,data) {
        var target = $(this).data('update-target');
        $('.' + target).html(data);
    });
// });


  $('#search-trigger button').on('click', function(){
    $.ajax({
      type: "POST",
      data: { },
      dataType: "html"
    }).success(function(response){
    });
  })

  $('.select2').each(function(i, e){
  var select = $(e)
  options = {
    initSelection : function (e, callback) {
        var data = [];
        // vals = JSON.parse(e.val());
        vals = e.data('initselection')
        $(vals).each(function () {
          if (this.id !== null){
            data.push({id: this.id, text: this.text});
          }
        });
        if (data.length <= 0 ){
          select.select2("val", "");
        }
        else {
          callback(data);
        }
    },
    allowClear: true,
    multiple:true,
    maximumSelectionSize:3,
    }
  if (select.hasClass('ajax')) {
    options.ajax = {
      url: select.data('source'),
      dataType: 'json',
      // data: function(term, page) { return { q: term, page: page, per: 10 } },
      data: function(term, page) { return { q: term, page: page, per: 10 }},
      results: function(data) { return { results: data } }
    }
    options.dropdownCssClass = "filterDrop"
  }
  select.select2(options)
})

  function ShowTooltip(selector) {
    $(selector).mouseover(function() {
        var tooltip_width = $(this).find(".helper_tooltip").width();
        var elem_width = $(this).width();
        $(".helper_tooltip .tooltip_triangle").css("margin-left", "" + (tooltip_width/2 - 10) + "px");
        $(".helper_tooltip").css("margin-left", "-" + (elem_width/2 + tooltip_width/2) + "px");
    });
}

ShowTooltip(".tooltip_wrapper");

});
