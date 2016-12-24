require_dependency 'sento/kanban/concerns/activity_creator'
require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class CreateCardArchivedActivity
      include Interactor
      include Sento::Kanban::ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        context.fail! unless context.archived

        key = 'sento.kanban.card_archived'
        values = { card_title: context.card.title,
                   card_id: context.card.id,
                   card_link: true }

        create_activity_from(context, key, values)
      end
    end
  end
end
