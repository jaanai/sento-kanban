require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class CardsController < ApplicationController
      before_action :fetches_current_board
      before_action :fetches_current_column
      before_action :build_new_card, only: [:new, :create]
      before_action :set_card, only: [:show, :edit_title, :edit_description,
                                      :update, :destroy, :archive]
      before_action :build_new_comment, only: :show

      respond_to :html, :json

      # GET /boards/1/columns/1/cards
      # GET /boards/1/cards
      def index; end

      # GET /boards/1/columns/1/cards/1
      # GET /boards/1/cards/1
      # GET /cards/1
      def show
        respond_modal_with @card
      end

      # GET /boards/1/columns/1/cards/new
      # GET /boards/1/cards/new
      def new; end

      # GET /boards/1/columns/1/cards/1/edit/description
      # GET /boards/1/cards/1/edit/description
      # GET /cards/1/edit/description
      def edit_description; end

      # GET /boards/1/columns/1/cards/1/edit/title
      # GET /boards/1/cards/1/edit/title
      # GET /cards/1/edit/title
      def edit_title; end

      # POST /boards/1/columns/1/cards
      # POST /boards/1/cards
      def create
        if @new_card.save
          CreateNewCardCreatedActivity.call(board: @board, column: @column,
                                            card: @new_card, user: current_user)
        else
          build_flash_message(:error)
        end
        render :create
      end

      # PATCH/PUT /boards/1/columns/1/cards/1
      # PATCH/PUT /boards/1/cards/1
      # PATCH/PUT /cards/1
      def update
        previous_column = @card.column.dup
        if @card.update(card_params)
          create_activity_card_moved_from(previous_column) if @card.moved?
        else
          build_flash_message(:error)
        end
        render :update
      end

      # DELETE /boards/1/columns/1/cards/1
      # DELETE /boards/1/cards/1
      # DELETE /cards/1
      def destroy
        @card.destroy
        build_flash_message(:success)
        redirect_to board_path(@board)
      end

      # PATCH /boards/1/cards/1/archive
      # PATCH /cards/1/archive
      def archive
        @card.archive
        CreateCardArchivedActivity.call(board: @board, card: @card,
                                        user: current_user)
        render :archive
      end

      private

      def fetches_current_board
        return unless params.key?(:board_id)

        @board = current_user.boards.find(params[:board_id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, board: :not_found)
        redirect_to root_url
      end

      def fetches_current_column
        return unless params.key?(:column_id)

        @column = @board.columns.find(params[:column_id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, column: :not_found)
        redirect_to board_url(@board)
      end

      def cards_source
        @column || @board || current_user
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_card
        @card = cards_source.cards.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, card: :not_found)
        redirect_to board_url(@board)
      end

      def build_new_card
        @new_card = cards_source.cards.new(card_params)
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

      def create_activity_card_moved_from(previous_column)
        CreateCardMovedActivity.call(board: @board, card: @card,
                                     previous_column: previous_column,
                                     new_column: @card.column,
                                     user: current_user)
      end

      def i18n_resource_name
        t('sento.kanban.card')
      end
    end
  end
end
