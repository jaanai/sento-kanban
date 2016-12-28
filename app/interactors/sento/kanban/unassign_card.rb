module Sento
  module Kanban
    class UnassignCard
      include Interactor::Organizer

      organize RemoveUserFromCardAssignees, CreateCardUnassignedActivity,
               NotifyCardWatcher
    end
  end
end
