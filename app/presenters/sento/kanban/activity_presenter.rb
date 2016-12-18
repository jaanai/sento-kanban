require_dependency 'sento/kanban/concerns/avatar_presenter'

module Sento
  module Kanban
    class ActivityPresenter < BasePresenter
      include Sento::Kanban::AvatarPresenter

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
        I18n.t(@model.i18n_key, computed_i18n_values)
      end

      def timestamp
        I18n.l(@model.created_at, format: :long)
      end

      private

      def computed_i18n_values
        return @model.i18n_values unless @model.i18n_values.key?(:card_link)

        card_id = @model.i18n_values[:card_id]
        @model.i18n_values[:card_link] = h.sento_kanban.card_url(card_id)
        @model.i18n_values
      end
    end
  end
end
