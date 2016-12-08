require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class CardsController < ApplicationController
      before_action :fetches_current_board
      before_action :fetches_current_column
      before_action :build_new_card, only: [:new, :create]
      before_action :set_card, only: [:show, :edit, :update, :destroy, :archive]
      before_action :build_new_comment, only: :show
      respond_to :html, :json

      # GET /boards/1/columns/1/cards
      def index; end

      # GET /boards/1/columns/1/cards/1
      def show
        respond_modal_with @card
      end

      # GET /boards/1/columns/1/cards/new
      def new; end

      # GET /boards/1/columns/1/cards/1/edit
      def edit; end

      # POST /boards/1/columns/1/cards
      def create
        build_flash_message(:error) unless @new_card.save
        render :create
      end

      # PATCH/PUT /boards/1/columns/1/cards/1
      def update
        build_flash_message(:error) unless @card.update(card_params)
        render :update
      end

      # DELETE /boards/1/columns/1/cards/1
      def destroy
        @card.destroy
        build_flash_message(:success)
        redirect_to board_path(@board)
      end

      # PATCH /boards/1/columns/1/cards/1/archive
      def archive
        @card.archive
        render :archive
      end

      private

      def fetches_current_board
        @board = current_user.boards.find(params[:board_id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, board: :not_found)
        redirect_to root_url
      end

      def fetches_current_column
        @column = @board.columns.find(params[:column_id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, column: :not_found)
        redirect_to board_url(@board)
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_card
        @card = @column.cards.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, card: :not_found)
        redirect_to board_url(@board)
      end

      def build_new_card
        @new_card = @column.cards.new(card_params)
      end

      def build_new_comment
        @new_comment = @card.comments.new
      end

      # Only allow a trusted parameter "white list" through.
      def card_params
        return {} unless params.key?(:card)

        params.require(:card).permit(:title, :description, :card_order_position,
                                     :column_id)
      end

      def i18n_resource_name
        t('sento.kanban.card')
      end
    end
  end
end
