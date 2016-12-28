module Sento
  module Kanban
    class AssignCard
      include Interactor::Organizer

      organize AddUserAsCardAssignee, CreateCardAssignedActivity,
               NotifyCardWatcher
    end
  end
end
