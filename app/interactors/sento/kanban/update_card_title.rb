require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class UpdateCardTitle
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        card = context.card

        context.previous_title = card.title.dup
        context.card_renamed = card.update(title: context.params[:title])
      end
    end
  end
end
