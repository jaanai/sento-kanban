module Sento
  module Kanban
    class RemoveCardMember
      include Interactor::Organizer

      organize RemoveMemberFromCard, CreateMemberLeftCardActivity,
               NotifyCardWatcher
    end
  end
end
