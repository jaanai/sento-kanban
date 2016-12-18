module Sento
  module Kanban
    class CardPresenter < BasePresenter
      def column_name
        object.column.name
      end

      def page_title
        I18n.t('sento.kanban.cards.page_title', card_name: object.title,
                                                board_name: object.board.title)
      end

      def activities
        object.activities.includes(:author).order(created_at: :desc)
      end

      def where_is_the_card
        I18n.t('sento.kanban.cards.where_is_the_card',
               column_name: column_name,
               board_title: object.board.title).html_safe
      end

      def card_path
        h.card_path(object)
      end

      def json_keys
        [:title, :where_is_the_card, :card_path]
      end

      private

      def object
        return @model if @model.is_a?(Sento::Kanban::Card)
        Sento::Kanban::Card.find(@model._id) if @model.is_a?(Hashie::Mash)
      end
    end
  end
end
