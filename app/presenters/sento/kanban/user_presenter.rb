module Sento
  module Kanban
    class UserPresenter < BasePresenter
      def avatar_url_or_fallback
        if @model.respond_to?(:avatar_url)
          @model.avatar_url
        else
          initials = generate_intials_from(@model)
          h.render partial: 'sento/kanban/shared/default_avatar',
                   locals: { initials: initials, title: avatar_title }
        end
      end

      def avatar_title
        visible_information_from(@model, initials: false)
      end

      private

      def generate_intials_from(model)
        visible_information_from(model, initials: true).try(:upcase)
      end

      def visible_information_from(model, options = {})
        if model.respond_to?(:firstname) && model.respond_to?(:lastname)
          build_using_underscored_first_and_last_names_from(model, options)
        elsif model.respond_to?(:first_name) && model.respond_to?(:last_name)
          build_using_first_and_last_names_from(model, options)
        elsif model.respond_to?(:username)
          build_using_username_from(model, options)
        elsif model.respond_to?(:email)
          build_using_email_from(model, options)
        end
      end

      def build_using_underscored_first_and_last_names_from(model, options)
        values = [model.firstname, model.lastname]
        options[:initials] ? values.map(&:first).join('') : values.join(' ')
      end

      def build_using_first_and_last_names_from(model, options)
        values = [model.firstname, model.lastname]
        options[:initials] ? values.map(&:first).join('') : values.join(' ')
      end

      def build_using_username_from(model, options)
        return model.username unless options[:initials]
        model.username.first_and_last
      end

      def build_using_email_from(model, options)
        return model.email unless options[:initials]
        model.email[0..1]
      end
    end
  end
end
