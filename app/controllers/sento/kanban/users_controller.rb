module Sento
  module Kanban
    class UsersController < ApplicationController
      autocomplete :user, :username, full: true

      skip_before_action :ensure_user_has_a_username

      respond_to :html, :json

      def update
        current_user.update(user_params)
        create_and_assing_open_card
        render :update
      end

      def ask_username
        render layout: 'modal'
      end

      def check_username
        status = ::User.exists?(username: params[:username]) ? 422 : 200

        render json: {}, status: status
      end

      private

      def user_params
        params.require(:user).permit(:username)
      end
    end
  end
end
