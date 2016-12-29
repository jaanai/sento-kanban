require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class ReindexCards
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        Rails.logger.info '[SearchKick] Re-indexing the Card collection ...'
        Sento::Kanban::Card.reindex
      end
    end
  end
end
