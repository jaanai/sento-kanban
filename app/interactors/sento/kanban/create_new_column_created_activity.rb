module Sento
  module Kanban
    class CreateNewColumnCreatedActivity
      include Interactor
      include ActivityCreator

      def call
        key = 'sento.kanban.new_column_created'
        values = { name: context.column.name }

        create_activity_from(context, key, values)
      end
    end
  end
end
