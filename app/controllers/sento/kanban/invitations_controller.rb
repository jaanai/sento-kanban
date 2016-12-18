module Sento
  module Kanban
    class InvitationsController < ApplicationController
      skip_before_action :ensure_user_has_a_username
      before_action :set_invitation, only: [:show]
      before_action :fetches_board

      # GET /invitations/1
      def show
        render 'sento/kanban/shared/profile/show'
      end

      # POST /boards/1/users/1/add
      def add
        new_user = Invitation.find_by(id: params[:invitation_id])
        @context = AddAUserInABoard.call(author: current_user, board: @board,
                                         new_user: new_user)

        if @context.errors.present?
          flash[:error] = t('sento.kanban.messages.already_in_this_board')
        end
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, user: :not_found)
        redirect_to board_url(@board)
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_invitation
        @invitation = Sento::Kanban::Invitation.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, invitation: :not_found)
        redirect_to root_path
      end

      def fetches_board
        @board = current_user.current_board
      end

      def i18n_resource_name
        t('sento.kanban.user')
      end
    end
  end
end
