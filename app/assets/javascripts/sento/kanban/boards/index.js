$(document).on('ready page:load', function() {
  if ($('.boards.index').length > 0)
    loadPageContentAjax();
});
