module Sento
  module Kanban
    class UnassignCard
      include Interactor::Organizer

      organize RemoveUserFromCardAssignees, ReindexCards,
               CreateCardUnassignedActivity, NotifyCardWatcher
    end
  end
end
