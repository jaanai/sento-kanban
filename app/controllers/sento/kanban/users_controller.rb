module Sento
  module Kanban
    class UsersController < ApplicationController
      skip_before_action :ensure_user_has_a_username
      before_action :fetches_board, only: [:create, :add]

      respond_to :html, :json

      # GET /users/1
      def show
        @user = ::User.find(params[:id])
        render 'sento/kanban/shared/profile/show'
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, user: :not_found)
        redirect_to root_path
      end

      # POST /boards/1
      def create
        @context = CreateAndInviteAUserInABoard.call(params: invite_params,
                                                     board: @board,
                                                     author: current_user)
      end

      # PUT/PATCH /boards/1
      def update
        current_user.update(user_params)
        create_and_assing_open_card
        render :update
      end

      # GET /users/ask-username
      def ask_username
        render layout: 'modal'
      end

      # GET /users/check-username
      def check_username
        status = ::User.exists?(username: params[:username]) ? 422 : 200

        render json: {}, status: status
      end

      # GET /users/invite
      def invite
        existing_user = find_user_from_email
        if existing_user
          render json: {}, status: 422
        else
          render :ask_username_before_invite
        end
      end

      # POST /boards/1/users/1/add
      def add
        new_user = ::User.find_by(id: params[:user_id])
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

      def user_params
        params.require(:user).permit(:username)
      end

      def invite_params
        params.require(:invite).permit(:email, :username)
      end

      def fetches_board
        @board = current_user.current_board
      end

      def find_user_from_email
        ::User.exists?(email: params[:email])
      end

      def i18n_resource_name
        t('sento.kanban.user')
      end
    end
  end
end
