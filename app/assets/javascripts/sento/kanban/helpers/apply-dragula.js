var sentoKanbanDragula = null;

function applyDragula() {
  if (sentoKanbanDragula)
    sentoKanbanDragula.destroy();

  sentoKanbanDragula = dragula($('.sento-kanban-cards').toArray(), {
    copySortSource: true
  }).on('drop', function(element, target, source) {
    var targetColumnId = $(target).data('column-id'),
        cardPosition = $(target).find('a.card-action-link').index($(element));

    $.ajax({
      url: $('body').data('mount-path') + '/cards/' + $(element).data('card-id'),
      method: 'PATCH',
      data: { card: { card_order_position : cardPosition, column_id: targetColumnId } }
    });
  });
}
