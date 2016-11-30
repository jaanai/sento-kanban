require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class ColumnsController < ApplicationController
      before_action :fetches_current_board
      before_action :set_column, only: [:show, :edit, :update, :destroy]
      before_action :fetches_all_boards, only: :index
      respond_to :html, :json

      # GET /boards/1/columns
      def index; end

      # GET /boards/1/columns/1
      def show; end

      # GET /boards/1/columns/new
      def new
        @new_column = @board.columns.new
      end

      # GET /boards/1/columns/1/edit
      def edit
      end

      # POST /boards/1/columns
      def create
        @new_column = @board.columns.new(column_params)
        @new_column.position = @board.columns.count
        @new_column.save
      end

      # PATCH/PUT /boards/1/columns/1
      def update
        if @board.update(column_params)
          redirect_to @board, notice: 'Board was successfully updated.'
        else
          render :edit
        end
      end

      # DELETE /boards/1/columns/1
      def destroy
        @board.destroy
        redirect_to boards_url, notice: 'Board was successfully destroyed.'
      end

      private

      def fetches_current_board
        @board = Board.find(params[:board_id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = t('messages.record_not_found', name: t('board'))
        redirect_to root_url
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_column
        @column = @board.columns.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = t('messages.record_not_found', name: t('board'))
        redirect_to action: :index
      end

      # Only allow a trusted parameter "white list" through.
      def column_params
        params.require(:column).permit(:name)
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
