require_dependency 'sento/kanban/concerns/activity_creator'
require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class CreateMemberLeftCardActivity
      include Interactor
      include Sento::Kanban::ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        key = 'sento.kanban.member_left_card'
        values = { member_username: context.user.username,
                   card_title: context.card.title }

        create_activity_from(context, key, values)
      end
    end
  end
end
