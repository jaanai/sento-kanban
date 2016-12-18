module Sento
  module Kanban
    class CreateNewBoardMemberActivity
      include Interactor
      include ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        key = 'sento.kanban.new_board_member'
        values = { board_title: context.board.title,
                   member_username: context.new_user.username }

        create_activity_from(context, key, values)
      end
    end
  end
end
