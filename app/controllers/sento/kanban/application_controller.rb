module Sento
  module Kanban
    class ApplicationController < ActionController::Base
      protect_from_forgery with: :exception

      before_action :authenticate_user!, if: :using_devise?

      after_action :prepare_unobtrusive_flash

      private

      # TODO : Refactor this method
      def build_flash_message(type, options = {})
        final_action_name = action_name
        final_resource_name = i18n_resource_name

        if options.present?
          final_resource_name = options.keys.first.to_s
          key = options.values.first
        else
          final_action_name << 'e' unless final_action_name.ends_with?('e')

          key = if type == :success
                  "#{final_action_name}d_object"
                else
                  "not_#{final_action_name}d_object"
                end
        end

        flash[type] = t("sento.kanban.messages.#{key}",
                        name: final_resource_name)
      end

      def using_devise?
        Sento::Kanban.using_devise == true
      end
    end
  end
end
