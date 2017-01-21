require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class FilterBoardCards
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        query = Sento::Kanban::Card.default_elasticsearch_query.dup

        unless clear == 'all'
          query = assignees_filtering_in(query)
          query = archived_cards_only(query) if archived == 'only'
        end

        context.filtered_cards = Sento::Kanban::Card.search(query, load: false)
      end

      private

      def assignee
        context.search[:assignee].reject(&:blank?)
      end

      def clear
        context.search[:clear]
      end

      def archived
        context.search[:archived]
      end

      def assignee_instances
        ::User.select(:id).where(username: assignee).all
      end

      def assignees_filtering_in(query)
        query[:where][:assignee_ids] ||= []

        query[:where][:assignee_ids] << nil if assignee.delete('empty').present?

        if assignee.present?
          query[:where][:assignee_ids] |= assignee_instances.map(&:id)
        end

        if query[:where][:assignee_ids].blank?
          query[:where].delete(:assignee_ids)
        end

        query
      end

      def archived_cards_only(query)
        query[:where][:archived] = true
        query
      end
    end
  end
end
