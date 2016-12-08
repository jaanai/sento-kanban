module Sento
  module Kanban
    class UserPresenter < BasePresenter
      include Sento::Kanban::UserAvatarPresenter

      def avatar_url_or_fallback
        model_avatar_or_fallback(@model)
      end
    end
  end
end
