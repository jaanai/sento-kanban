require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class RemoveUserFromCardAssignees
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        context.card.assignees.delete(context.user)
      end
    end
  end
end
