module Sento
  module Kanban
    class BoardPresenter < BasePresenter
      def page_title
        I18n.t('sento.kanban.boards.page_title', board_name: @model.title)
      end

      def users
        @model.users
      end

      def activities
        @model.activities.includes(:author).order(created_at: :desc)
      end
    end
  end
end
