require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class UpdateCardDescription
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        card = context.card

        updated = card.update(description: context.params[:description])
        context.card_description_updated = updated
      end
    end
  end
end
