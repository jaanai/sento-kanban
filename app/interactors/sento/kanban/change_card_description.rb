module Sento
  module Kanban
    class ChangeCardDescription
      include Interactor::Organizer

      organize UpdateCardDescription, CreateCardDescriptionUpdatedActivity,
               NotifyCardWatcher
    end
  end
end
