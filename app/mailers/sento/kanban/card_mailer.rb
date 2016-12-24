module Sento
  module Kanban
    class CardMailer < ApplicationMailer
      def notify_watcher(watcher, card)
        @user = watcher

        @card_activity = card.activities.last

        mail(to: @user.email,
             subject: t('.subject', board_title: card.board.title))
      end
    end
  end
end
