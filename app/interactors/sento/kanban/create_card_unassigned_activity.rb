require_dependency 'sento/kanban/concerns/activity_creator'
require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class CreateCardUnassignedActivity
      include Interactor
      include Sento::Kanban::ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        key = 'sento.kanban.assignee_removed'
        values = { card_title: context.card.title,
                   card_id: context.card.id,
                   card_link: true,
                   member_username: presented_user.fullname_or_username }

        create_activity_from(context, key, values)
      end

      private

      def presented_user
        Sento::Kanban::UserPresenter.new(context.user)
      end
    end
  end
end
