module Sento
  module Kanban
    class CreateNewBoardCreatedActivity
      include Interactor
      include ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        key = 'sento.kanban.new_board_created'
        values = { board_title: context.board.title }

        create_activity_from(context, key, values)
      end
    end
  end
end
