require_dependency 'sento/kanban/concerns/interactor_timer'

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
        new_user = ::User.create(context.params.merge(virtual: true))
        if new_user.valid?
          context.new_user = new_user
        else
          context.fail!(errors: new_user.errors.to_h)
        end
      end

      def send_invitation_email
        UserMailer.invite_user(context.new_user, presented_author,
                               context.board).deliver_now
        context.message = emojify(I18n.t('sento.kanban.messages.user_invited',
                                  email: context.new_user.email).html_safe)
      end

      def presented_author
        Sento::Kanban::UserPresenter.new(context.author)
      end

      def emojify(html)
        ApplicationController.helpers.emojify(html)
      end
    end
  end
end
