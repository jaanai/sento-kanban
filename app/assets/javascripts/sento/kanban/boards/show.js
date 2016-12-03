$(document).on('ready page:load', function() {
  if ($('.boards.show').length > 0)
    loadPageContentAjax();
});
