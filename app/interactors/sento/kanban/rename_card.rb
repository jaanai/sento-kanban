module Sento
  module Kanban
    class RenameCard
      include Interactor::Organizer

      organize UpdateCardTitle, CreateCardRenamedActivity, NotifyCardWatcher
    end
  end
end
