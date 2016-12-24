module Sento
  module Kanban
    class MoveCard
      include Interactor::Organizer

      organize UpdateCardColumn, CreateCardMovedActivity, NotifyCardWatcher
    end
  end
end
