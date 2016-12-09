require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class CommentsController < ApplicationController
      before_action :fetches_current_board
      before_action :fetches_current_card
      before_action :build_new_comment, only: :create
      before_action :set_comment, only: [:edit, :update, :destroy]

      # GET /boards/1/cards/1/comments/1/edit
      def edit; end

      # POST /boards/1/cards/1/comments
      def create
        if @new_comment.save
          CreateNewCommentCreatedActivity.call(board: @board, card: @card,
                                               comment: @new_comment,
                                               user: current_user)
        else
          build_flash_message(:error)
        end
        render :create
      end

      # PATCH/PUT /boards/1/cards/1/comments/1
      def update
        build_flash_message(:error) unless @comment.update(comment_params)
        render :update
      end

      # DELETE /boards/1/cards/1/comments/1
      def destroy
        @comment.destroy
        build_flash_message(:success)
        redirect_to board_path(@board)
      end

      private

      def fetches_current_board
        @board = current_user.boards.find(params[:board_id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, board: :not_found)
        redirect_to root_url
      end

      def fetches_current_card
        @card = @board.cards.find(params[:card_id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, card: :not_found)
        redirect_to board_url(@board)
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = @card.comments.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, comment: :not_found)
        redirect_to board_url(@board)
      end

      def build_new_comment
        @new_comment = @card.comments.new(comment_params)
        @new_comment.author = current_user
      end

      # Only allow a trusted parameter "white list" through.
      def comment_params
        return {} unless params.key?(:comment)

        params.require(:comment).permit(:body)
      end

      def i18n_resource_name
        t('sento.kanban.comment')
      end
    end
  end
end
