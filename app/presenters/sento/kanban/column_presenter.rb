module Sento
  module Kanban
    class ColumnPresenter < BasePresenter
      def cards
        send("cards_using_#{Sento::Kanban.search_adapter}")
      rescue NoMethodError
        cards_using_activerecord
      end

      private

      def cards_using_activerecord
        Array(@model.cards.without_archived.rank(:card_order))
      end

      def cards_using_elasticsearch
        search_params = Sento::Kanban::Card.default_elasticsearch_query.dup
        search_params[:where][:column_id] = @model.id
        Sento::Kanban::Card.search(search_params)
      end
    end
  end
end
