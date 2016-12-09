module Sento
  module Kanban
    class ActivityPresenter < BasePresenter
      include Sento::Kanban::UserAvatarPresenter

      def icon_url
        model_avatar_or_fallback(@model.author)
      end

      def author_fullname
        author = @model.author
        if author.respond_to?(:firstname) && author.respond_to?(:lastname)
          [author.firstname, author.lastname].join(' ')
        elsif author.respond_to?(:first_name) && author.respond_to?(:last_name)
          [author.first_name, author.last_name].join(' ')
        elsif author.respond_to?(:username)
          author.username
        end
      end

      def description
        I18n.t(@model.i18n_key, @model.i18n_values)
      end

      def timestamp
        I18n.l(@model.created_at, format: :long)
      end
    end
  end
end
