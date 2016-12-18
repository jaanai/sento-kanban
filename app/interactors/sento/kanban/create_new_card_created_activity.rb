module Sento
  module Kanban
    class CreateNewCardCreatedActivity
      include Interactor
      include ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        key = 'sento.kanban.new_card_created'
        values = { card_title: context.card.title,
                   card_id: context.card.id,
                   card_link: true,
                   column_name: context.column.name }

        create_activity_from(context, key, values)
      end
    end
  end
end
