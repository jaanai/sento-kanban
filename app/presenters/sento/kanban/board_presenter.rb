module Sento
  module Kanban
    class BoardPresenter < BasePresenter
      def page_title
        I18n.t('sento.kanban.boards.page_title', board_name: @model.title)
      end

      def activities
        @model.activities.includes(:author).order(created_at: :desc)
      end

      def has_other_members?
        @model.all_members.count > 1
      end

      def members_for_select
        @model.all_members.order(:username).map(&:username)
      end
    end
  end
end
