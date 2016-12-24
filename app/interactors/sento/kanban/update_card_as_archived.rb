require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class UpdateCardAsArchived
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        context.archived = context.card.archive
      end
    end
  end
end
