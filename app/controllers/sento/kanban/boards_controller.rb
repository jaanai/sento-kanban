require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class BoardsController < ApplicationController
      before_action :set_board, only: [:show, :edit, :update, :destroy]
      before_action :fetches_all_boards, only: :index
      respond_to :html, :json

      # GET /boards
      def index; end

      # GET /boards/1
      def show
        @columns = @board.columns
      end

      # GET /boards/new
      def new
        @board = Board.new
        respond_modal_with @board
      end

      # GET /boards/1/edit
      def edit
      end

      # POST /boards
      def create
        @board = Board.new(board_params)
        fetches_all_boards if @board.save
        flash[:notice] = t('messages.was_successfully_created',
                           name: t('board'))
        render :new
      end

      # PATCH/PUT /boards/1
      def update
        if @board.update(board_params)
          redirect_to @board, notice: t('messages.was_successfully_updated',
                                        name: t('board'))
        else
          render :edit
        end
      end

      # DELETE /boards/1
      def destroy
        @board.destroy
        redirect_to boards_url, notice: t('messages.was_successfully_destroyed',
                                          name: t('board'))
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_board
        @board = Board.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = t('messages.record_not_found', name: t('board'))
        redirect_to action: :index
      end

      # Only allow a trusted parameter "white list" through.
      def board_params
        params.require(:board).permit(:title, :description)
      end

      def column_params
        return {} unless params.key?(:column)
        params[:column].permit(:name)
      end

      def fetches_all_boards
        @boards = Board.all
      end
    end
  end
end
