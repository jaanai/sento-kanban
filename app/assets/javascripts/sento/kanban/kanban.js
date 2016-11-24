$(document).on('ready page:load', function() {
  $('.sento-kanban').perfectScrollbar();
  $('.sento-kanban-column').perfectScrollbar();

  dragula($('.sento-kanban-cards').toArray(), {
    copySortSource: true
  });
});
