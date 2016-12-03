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
        respond_to do |format|
          format.html
          format.js { @columns = @board.columns }
        end
      end

      # GET /boards/new
      def new
        @board = Board.new
        respond_modal_with @board
      end

      # GET /boards/1/edit
      def edit; end

      # POST /boards
      def create
        @board = Board.new(board_params)
        fetches_all_boards if @board.save
        flash[:notice] = t('sento.kanban.messages.was_successfully_created',
                           name: t('sento.kanban.board'))
        render :new
      end

      # PATCH/PUT /boards/1
      def update
        if @board.update(board_params)
          redirect_to @board, notice: t('sento.kanban.messages.was_successfully_updated',
                                        name: t('sento.kanban.board'))
        else
          render :edit
        end
      end

      # DELETE /boards/1
      def destroy
        @board.destroy
        redirect_to boards_url, notice: t('sento.kanban.messages.was_successfully_destroyed',
                                          name: t('board'))
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_board
        @board = Board.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = t('sento.kanban.messages.record_not_found',
                          name: t('sento.kanbanboard'))
        redirect_to action: :index
      end

      # Only allow a trusted parameter "white list" through.
      def board_params
        params.require(:board).permit(:title, :description)
      end

      def fetches_all_boards
        @boards = Board.all
      end
    end
  end
end
