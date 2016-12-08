module Sento
  module Kanban
    class InviteAUserInABoard
      include Interactor::Organizer

      organize AddUserToABoard, CreateNewBoardCreatedActivity
    end
  end
end
