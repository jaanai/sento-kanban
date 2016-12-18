module Sento
  module Kanban
    class AddAUserInABoard
      include Interactor::Organizer

      organize AddUserToABoard, CreateNewBoardMemberActivity
    end
  end
end
