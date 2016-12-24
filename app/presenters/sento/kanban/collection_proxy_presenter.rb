module Sento
  module Kanban
    class CollectionProxyPresenter < BasePresenter
      def members
        ::User.joins(:board_links)
              .where(sento_kanban_board_links: { board_id: @model },
                     virtual: false).distinct
      end

      def virtual_members
        ::User.joins(:board_links)
              .where(sento_kanban_board_links: { board_id: @model },
                     virtual: true).distinct
      end

      def activities
        Sento::Kanban::Activity.includes(:author)
                               .where(board: @model).order(created_at: :desc)
      end
    end
  end
end
