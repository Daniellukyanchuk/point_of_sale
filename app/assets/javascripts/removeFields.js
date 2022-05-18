
  // Wait for turbolinks to load, otherwise `document.querySelectorAll()` won't work
  window.addEventListener('turbolinks:load', function(){
    $(document).off('click', 'form .remove_fields').on('click', 'form .remove_fields', function(event) {
      $(this).prev('.nested-field-destroy').val('1');
      $(this).closest('.nested-fields').hide();
      return event.preventDefault();
    });
  })