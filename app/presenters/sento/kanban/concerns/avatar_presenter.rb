module Sento
  module Kanban
    #
    # This concern embbed the relative code to the user avatar
    # building: Picture otherwise initials.
    #
    module AvatarPresenter
      extend ActiveSupport::Concern

      def model_avatar_or_fallback(user, options = {})
        if user.respond_to?(:avatar_url)
          h.image_tag(user.avatar_url)
        else
          initials = generate_intials_from(user)
          title = avatar_title(user)
          css_classes = options[:css_classes]
          if options[:mailer] == true
            initials_avatar_for_email(initials, title)
          else
            initials_avatar_for_web(initials, title, css_classes)
          end
        end
      end

      private

      def initials_avatar_for_email(initials, title)
        "<p style=\"margin: 0;font-size: 14px;line-height: 17px; " \
                   "background-color: #00a2ff; color: #fff; line-height: 1; " \
                   "border-radius: 3px; padding-top: 11px; " \
                   "padding-bottom: 8px; padding-left: 4px; " \
                   "padding-right: 4px; \">#{initials}</p>"
      end

      def initials_avatar_for_web(initials, title, css_classes)
        "<div class='board-member#{" #{css_classes}" if css_classes}' title='#{title}'>" \
          "#{initials}" \
        '</div>'.html_safe
      end

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
        return unless user.username
        user.username[0..1]
      end

      def build_using_email_from(user, options)
        return user.email unless options[:initials]
        user.email[0..1]
      end
    end
  end
end
