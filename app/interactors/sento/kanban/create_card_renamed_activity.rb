module Sento
  module Kanban
    class CreateCardRenamedActivity
      include Interactor
      include ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
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
