module Sento
  module Kanban
    class CreateInvitedUnconfirmedMemberActivity
      include Interactor
      include ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        key = 'sento.kanban.invited_unconfirmed_member'
        values = { board_title: context.board.title }

        create_activity_from(context, key, values)
      end
    end
  end
end
