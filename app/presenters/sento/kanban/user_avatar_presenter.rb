module Sento
  module Kanban
    module UserAvatarPresenter
      extend ActiveSupport::Concern

      def model_avatar_or_fallback(user)
        if user.respond_to?(:avatar_url)
          h.image_tag(user.avatar_url)
        else
          initials = generate_intials_from(user)
          %(<div class="board-member" title="#{avatar_title(user)}">
              #{initials}
            </div>).html_safe
        end
      end

      private

      def avatar_title(user)
        visible_information_from(user, initials: false)
      end

      def generate_intials_from(user)
        visible_information_from(user, initials: true).try(:upcase)
      end

      def visible_information_from(user, options = {})
        if user.respond_to?(:firstname) && user.respond_to?(:lastname)
          build_using_underscored_first_and_last_names_from(user, options)
        elsif user.respond_to?(:first_name) && user.respond_to?(:last_name)
          build_using_first_and_last_names_from(user, options)
        elsif user.respond_to?(:username)
          build_using_username_from(user, options)
        elsif user.respond_to?(:email)
          build_using_email_from(user, options)
        end
      end

      def build_using_underscored_first_and_last_names_from(user, options)
        values = [user.firstname, user.lastname]
        options[:initials] ? values.map(&:first).join('') : values.join(' ')
      end

      def build_using_first_and_last_names_from(user, options)
        values = [user.firstname, user.lastname]
        options[:initials] ? values.map(&:first).join('') : values.join(' ')
      end

      def build_using_username_from(user, options)
        return user.username unless options[:initials]
        user.username[0..1]
      end

      def build_using_email_from(user, options)
        return user.email unless options[:initials]
        user.email[0..1]
      end
    end
  end
end
