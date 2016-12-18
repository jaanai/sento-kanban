require_dependency 'sento/kanban/concerns/service_downtime_handling_for_elasticsearch'

module Sento
  module Kanban
    class ApplicationController < ActionController::Base
      protect_from_forgery with: :exception

      before_action :authenticate_user!, if: :using_devise?
      before_action :ensure_user_has_a_username

      after_action :prepare_unobtrusive_flash

      include Sento::Kanban::ServiceDowntimeHandlingForElasticSearch

      def kanban_source
        Sento::Kanban.using_devise ? current_user.boards : Sento::Kanban::Board
      end
      helper_method :kanban_source

      private

      #
      # This method creates the @ask_username variable which is used later in
      # order to show the modal asking the user to choose a username in the case
      # the current_user doesn't have one.
      #
      def ensure_user_has_a_username
        @ask_username = current_user.username.blank?
      end

      def create_and_assing_open_card
        @open_card = session[:open_card]
        session.delete(:open_card)
      end

      # TODO : Refactor this method
      def build_flash_message(type, options = {})
        final_action_name = action_name.dup
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
