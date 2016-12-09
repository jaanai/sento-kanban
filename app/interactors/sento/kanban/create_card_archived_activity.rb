module Sento
  module Kanban
    class CreateCardArchivedActivity
      include Interactor
      include ActivityCreator

      def call
        key = 'sento.kanban.card_archived'
        values = { card_title: context.card.title,
                   card_id: context.card.id }

        create_activity_from(context, key, values)
      end
    end
  end
end
