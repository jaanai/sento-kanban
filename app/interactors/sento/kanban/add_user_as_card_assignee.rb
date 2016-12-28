require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class AddUserAsCardAssignee
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        context.card.assignees << context.user
      end
    end
  end
end
