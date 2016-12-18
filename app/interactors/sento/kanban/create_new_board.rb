module Sento
  module Kanban
    class CreateNewBoard
      include Interactor::Organizer

      organize AddUserToABoard, CreateNewBoardCreatedActivity
    end
  end
end
