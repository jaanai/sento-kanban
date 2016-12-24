require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class AddUserToABoard
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        board = context.board
        # new_user when adding a user to an existing board
        # author when creating a new board and adding the board creator
        new_user = context.new_user || context.author

        context.fail!(errors: { board: "can't be blank" }) unless board
        context.fail!(errors: { user: "can't be blank" }) unless new_user

        if new_user.is_a?(User)
          board.members << new_user
        elsif new_user.is_a?(Sento::Kanban::Invitation)
          board.virtual_members << new_user
        end
      rescue ActiveRecord::RecordInvalid
        context.fail!(errors: { user: 'is already in this board' })
      end
    end
  end
end
