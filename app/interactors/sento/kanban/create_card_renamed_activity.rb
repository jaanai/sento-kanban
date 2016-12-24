require_dependency 'sento/kanban/concerns/activity_creator'
require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class CreateCardRenamedActivity
      include Interactor
      include Sento::Kanban::ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        context.fail! unless context.card_renamed

        key = 'sento.kanban.card_renamed'
        values = { card_title: context.card.title,
                   card_id: context.card.id,
                   card_link: true,
                   previous_card_title: context.previous_title }

        create_activity_from(context, key, values)
      end
    end
  end
end
