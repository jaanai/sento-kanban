module Sento
  module Kanban
    class CreateNewInvitation
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        board = context.board
        inviter = context.author

        context.fail!(errors: { board: "can't be blank" }) unless board
        context.fail!(errors: { inviter: "can't be blank" }) unless inviter

        defined?(DeviseInvitable) ? invite_with_devise : invite_with_rails
      end

      private

      def invite_with_devise
        inviter.invite!(context.params)
      end

      def invite_with_rails
        create_new_user
        send_invitation_email
      end

      def create_new_user
        new_invitation = Sento::Kanban::Invitation.create(context.params.merge(
          board: context.board, inviter: context.author
        ))
        if new_invitation.valid?
          context.new_user = new_invitation
        else
          context.fail!(errors: new_invitation.errors.to_h)
        end
      end

      def send_invitation_email
        UserMailer.invite_user(context.new_user, context.author, context.board)
                  .deliver_now
        context.message = emojify(I18n.t('sento.kanban.messages.user_invited',
                                  email: context.new_user.email).html_safe)
      end

      def emojify(html)
        ApplicationController.helpers.emojify(html)
      end
    end
  end
end
