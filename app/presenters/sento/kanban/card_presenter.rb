module Sento
  module Kanban
    class CardPresenter < BasePresenter
      def column_name
        @model.column.name
      end

      def page_title
        I18n.t('sento.kanban.cards.page_title', card_name: @model.title,
                                                board_name: @model.board.title)
      end
    end
  end
end
