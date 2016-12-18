module Sento
  module Kanban
    class UserMailer < ApplicationMailer
      def invite_user(user, inviter, board)
        @user = user

        mail(to: @user.email,
             subject: t('.subject',
                        inviter_username: inviter.fullname_or_username,
                        inviter_mention_tag: inviter.username,
                        board_title: board.title))
      end
    end
  end
end
