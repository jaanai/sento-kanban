module Sento
  module Kanban
    class CollectionProxyPresenter < BasePresenter
      def users
        ::User.joins(:board_links)
              .where(sento_kanban_board_links: { board_id: @model }).uniq
      end

      def activities
        Sento::Kanban::Activity.includes(:author)
                               .where(board: @model).order(created_at: :desc)
      end
    end
  end
end
