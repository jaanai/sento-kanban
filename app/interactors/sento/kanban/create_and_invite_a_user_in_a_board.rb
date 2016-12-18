module Sento
  module Kanban
    class CreateAndInviteAUserInABoard
      include Interactor::Organizer

      organize EnsureNoUserAlreadyExistsByEmail, CreateNewInvitation,
               AddUserToABoard, CreateInvitedUnconfirmedMemberActivity
    end
  end
end
