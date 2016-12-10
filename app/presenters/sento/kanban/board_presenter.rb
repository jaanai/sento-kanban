module Sento
  module Kanban
    class BoardPresenter < BasePresenter
      def page_title
        I18n.t('sento.kanban.boards.page_title', board_name: @model.title)
      end
    end
  end
end
