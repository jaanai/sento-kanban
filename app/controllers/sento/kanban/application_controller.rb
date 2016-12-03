module Sento
  module Kanban
    class ApplicationController < ActionController::Base
      protect_from_forgery with: :exception
      after_filter :prepare_unobtrusive_flash

      private

      # TODO : Refactor this method
      def build_flash_message(type, options = {})
        final_action_name = action_name
        final_resource_name = i18n_resource_name

        if options.present?
          final_action_name = options.keys.first
          final_resource_name = options.values.first
        end

        final_action_name << 'e' unless final_action_name.ends_with?('e')

        key = if type == :success
                "#{final_action_name}d_object"
              else
                "not_#{final_action_name}d_object"
              end

        flash[type] = t("sento.kanban.messages.#{key}",
                        name: final_resource_name)
      end
    end
  end
end
