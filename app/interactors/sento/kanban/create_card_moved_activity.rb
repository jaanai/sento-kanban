require_dependency 'sento/kanban/concerns/activity_creator'
require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class CreateCardMovedActivity
      include Interactor
      include Sento::Kanban::ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        context.fail! unless context.card_moved

        key = 'sento.kanban.card_moved'
        values = { card_title: context.card.title,
                   card_id: context.card.id,
                   card_link: true,
                   previous_column_name: context.previous_column_name,
                   new_column_name: context.new_column_name }

        create_activity_from(context, key, values)
      end
    end
  end
end
