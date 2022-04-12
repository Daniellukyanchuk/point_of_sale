// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

function page_ready(){
  $(".chosen-select").chosen({
    no_results_text: "Oops, nothing found!"
    })
} 
 


jQuery(function() {

  // $(document).off('turbolinks:load').on('turbolinks:load', function() {
  
    $(document).off('click', 'form .remove_fields').on('click', 'form .remove_fields', function(event) {
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('.nested-fields').hide();
      return event.preventDefault();
    });
    $(document).off('click', 'form .add_fields').on('click', 'form .add_fields', function(event) {
      var regexp, time;
      time = new Date().getTime();
      regexp = new RegExp($(this).data('id'), 'g');
      $(this).before($(this).data('fields').replace(regexp, time));
      return event.preventDefault();
    });
  
  // })

});

$(function() {
  var inputFields = $("input:text, textarea");
  inputFields.focus(function() {
    $(this).css("box-shadow", "0 0 4px #666");
  });

  inputFields.blur(function() {
    $(this).css("box-shadow", "none");
  });
});


$(document).ready(page_ready);
window.addEventListener('turbolinks:load', page_ready);
  


// First, checks if it isn't implemented yet.
if (!String.prototype.format) {
  String.prototype.format = function() {
    var args = arguments;
    return this.replace(/{(\d+)}/g, function(match, number) { 
      return typeof args[number] != 'undefined'
        ? args[number]
        : match
      ;
    });
  };
}



