module Sento
  module Kanban
    class CreateCardArchivedActivity
      include Interactor
      include ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        key = 'sento.kanban.card_archived'
        values = { card_title: context.card.title,
                   card_id: context.card.id,
                   card_link: true }

        create_activity_from(context, key, values)
      end
    end
  end
end
