require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class RemoveMemberFromCard
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        context.card.watchers.delete(context.user)
      end
    end
  end
end
