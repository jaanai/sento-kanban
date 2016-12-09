module Sento
  module Kanban
    class CreateCardMovedActivity
      include Interactor
      include ActivityCreator

      def call
        key = 'sento.kanban.card_moved'
        values = { card_title: context.card.title,
                   card_id: context.card.id,
                   previous_column_name: context.previous_column.name,
                   new_column_name: context.new_column.name }

        create_activity_from(context, key, values)
      end
    end
  end
end
