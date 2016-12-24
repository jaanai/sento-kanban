module Sento
  module Kanban
    class AddNewCardMember
      include Interactor::Organizer

      organize AddMemberToCard, CreateMemberJoinedCardActivity,
               NotifyCardWatcher
    end
  end
end
