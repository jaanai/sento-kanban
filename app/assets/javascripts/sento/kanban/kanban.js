$(document).on('ready page:load', function() {
  $('.sento-kanban').perfectScrollbar();
  $('.sento-kanban-cards').perfectScrollbar();

  dragula($('.sento-kanban-cards').toArray(), {
    copySortSource: true
  });
});
