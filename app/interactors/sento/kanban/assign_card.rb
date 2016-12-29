module Sento
  module Kanban
    class AssignCard
      include Interactor::Organizer

      organize AddUserAsCardAssignee, ReindexCards, CreateCardAssignedActivity,
               NotifyCardWatcher
    end
  end
end
