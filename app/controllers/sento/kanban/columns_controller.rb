require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class ColumnsController < ApplicationController
      before_action :fetches_current_board
      before_action :set_column, only: [:show, :edit, :update, :delete,
                                        :destroy]
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
      def edit; end

      # POST /boards/1/columns
      def create
        @new_column = @board.columns.new(column_params)
        @new_column.position = @board.columns.count
        @new_column.save
      end

      # PATCH/PUT /boards/1/columns/1
      def update
        if @column.update(column_params)
          flash[:notice] = t('sento.kanban.messages.was_successfully_updated',
                             name: t('sento.kanban.column'))
        end
        render :update
      end

      # GET /boards/1/columns/1/delete
      def delete
        respond_modal_with @column
      end

      # DELETE /boards/1/columns/1
      def destroy
        @column.destroy
        redirect_to board_url(@board),
                    notice: t('sento.kanban.messages.was_successfully_destroyed',
                              name: t('sento.kanban.column'))
      end

      private

      def fetches_current_board
        @board = Board.find(params[:board_id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = t('sento.kanban.messages.record_not_found',
                          name: t('sento.kanban.column'))
        redirect_to root_url
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_column
        @column = @board.columns.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = t('sento.kanban.messages.record_not_found',
                          name: t('sento.kanban.column'))
        redirect_to action: :index
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
