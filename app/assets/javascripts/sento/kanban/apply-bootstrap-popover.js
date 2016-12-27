function applyBootstrapPopover() {
  $('*[data-toggle="popover"]').bind('click', function(event){
    event.preventDefault();

    if ($(this).data('bootstrap-popover') !== 'undefined') {
      var self = $(this),
          url = self.attr('href');

      $(this).data('bootstrap-popover', 'hooked');

      $.get(url, function(data) {
        self.popover({
          content: data
        }).popover('show');

        $('#' + self.attr('aria-describedby') + ' button[aria-label="Close"]').on('click', function() {
          $('#' + self.attr('aria-describedby')).popover('hide');
        });
      });
    }
  });
}
