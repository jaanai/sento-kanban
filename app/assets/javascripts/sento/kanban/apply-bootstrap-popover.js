function applyBootstrapPopover() {
  $('*[data-toggle="popover"]').bind('click', function(event){
    event.preventDefault();
    var self = $(this),
        url = self.attr('href');

    $.get(url, function(data) {
      self.popover({
        content: data
      }).popover('show');

      $('#' + self.attr('aria-describedby') + ' button[aria-label="Close"]').on('click', function() {
        $('#' + self.attr('aria-describedby')).popover('hide');
      });
    });
  });
}
