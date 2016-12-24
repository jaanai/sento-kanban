module Sento
  module Kanban
    class ArchiveCard
      include Interactor::Organizer

      organize UpdateCardAsArchived, CreateCardArchivedActivity,
               NotifyCardWatcher
    end
  end
end
