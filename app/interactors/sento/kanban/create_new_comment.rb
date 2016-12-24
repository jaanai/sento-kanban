module Sento
  module Kanban
    class CreateNewComment
      include Interactor::Organizer

      organize AddANewCommentToACard, CreateNewCommentCreatedActivity,
               NotifyCardWatcher
    end
  end
end
