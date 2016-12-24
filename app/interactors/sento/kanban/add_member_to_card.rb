require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class AddMemberToCard
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        context.card.watchers << context.user
      end
    end
  end
end
