require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class FilterBoardCards
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        query = assignees_filtering

        context.filtered_cards = Sento::Kanban::Card.search(query, load: false)
      end

      private

      def assignee
        context.search[:assignee]
      end

      def assignee_instance
        ::User.select(:id).find_by(username: assignee)
      end

      def assignees_filtering
        if assignee == 'empty' || assignee.blank?
          {
            where: {
              assignee_ids: [nil]
            }
          }
        else
          {
            where: {
              assignee_ids: [assignee_instance.id]
            }
          }
        end
      end
    end
  end
end
