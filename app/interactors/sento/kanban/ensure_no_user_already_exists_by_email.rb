require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class EnsureNoUserAlreadyExistsByEmail
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        email = context.params[:email]

        context.fail!(errors: { email: "can't be blank" }) unless email
        return unless ::User.exists?(email: email)

        context.fail!(errors: {
          email: I18n.t('errors.messages.taken')
        })
      end
    end
  end
end
