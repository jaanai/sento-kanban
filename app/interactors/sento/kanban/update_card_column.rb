require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class UpdateCardColumn
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        card = context.card

        context.previous_column_name = card.column.name.dup
        new_column_id = context.params[:column_id]
        context.card_moved = card.update(column_id: new_column_id)
        context.new_column_name = card.column.name.dup
      end
    end
  end
end
