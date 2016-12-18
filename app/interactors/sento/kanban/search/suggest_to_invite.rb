module Sento
  module Kanban
    module Search
      class SuggestToInvite
        include Interactor
        include Sento::Kanban::InteractorTimer

        def call
          context.members_result = build_invite_action if possible?
        end

        private

        def build_invite_action
          [
            {
              action_invite: true,
              email: context.query,
              description: I18n.t('sento.kanban.global_search.autocomplete' \
                                  '.actions.invite.description',
                                  email: context.query),
              invite_url: invite_url
            }
          ]
        end

        def possible?
          context.members_result.blank? && can_be_invited?
        end

        def email
          context.query
        end

        #
        # Requires at least a character, an @ symbol, and a character.
        #
        def can_be_invited?
          (email =~ /\w@\w/).present?
        end

        def router
          Sento::Kanban::Engine.routes.url_helpers
        end

        def invite_url
          router.invite_users_path(email: email)
        end
      end
    end
  end
end
