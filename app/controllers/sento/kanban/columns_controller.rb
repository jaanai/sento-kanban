require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class ColumnsController < ApplicationController
      before_action :fetches_current_board
      before_action :build_new_column, only: [:new, :create]
      before_action :set_column, only: [:show, :edit, :update, :delete,
                                        :destroy]
      before_action :fetches_all_boards, only: :index
      respond_to :html, :json

      # GET /boards/1/columns
      def index; end

      # GET /boards/1/columns/1
      def show; end

      # GET /boards/1/columns/new
      def new; end

      # GET /boards/1/columns/1/edit
      def edit; end

      # POST /boards/1/columns
      def create
        @new_column.position = @board.columns.count
        @new_column.save
      end

      # PATCH/PUT /boards/1/columns/1
      def update
        build_flash_message(@column.update(column_params) ? :success : :error)
        render :update
      end

      # GET /boards/1/columns/1/delete
      def delete
        respond_modal_with @column
      end

      # DELETE /boards/1/columns/1
      def destroy
        @column.destroy
        build_flash_message(:success)
        redirect_to board_url(@board)
      end

      private

      def fetches_current_board
        @board = Board.find(params[:board_id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, board: :not_found)
        redirect_to root_url
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_column
        @column = @board.columns.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, column: :not_found)
        redirect_to action: :index
      end

      def column_params
        return {} unless params.key?(:column)

        params[:column].permit(:name)
      end

      def fetches_all_boards
        @boards = Board.all
      end

      def build_new_column
        @new_column = @board.columns.new(column_params)
      end

      def i18n_resource_name
        t('sento.kanban.column')
      end
    end
  end
end
