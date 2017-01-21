function bindFilterOptions() {
  $('.filters form input[type="checkbox"]').on('change', function() {
    $(this).closest('form').submit();
  });

  $('.filters form select').on('change', function() {
    if ($('.filters form select option:selected').val() == '') {
      $(this).removeClass('selected');
    } else {
      $(this).addClass('selected');
    }

    $(this).closest('form').submit();
  });

  $('.filters form button[type="submit"].clear_filters').on('click', function(event) {
    event.preventDefault();

    $('.filters form input[type="checkbox"]').prop('checked', false);
    $('.filters form select option:selected').prop('selected', false).trigger('chosen:updated').parent().removeClass('selected');
    $(this).closest('form').submit();
  });
};
