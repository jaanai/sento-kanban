require_dependency 'sento/kanban/concerns/activity_creator'
require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class CreateNewColumnCreatedActivity
      include Interactor
      include Sento::Kanban::ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        key = 'sento.kanban.new_column_created'
        values = { name: context.column.name }

        create_activity_from(context, key, values)
      end
    end
  end
end
