require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class BoardsController < ApplicationController
      before_action :set_board, only: [:show, :edit, :update, :destroy]
      before_action :fetches_all_boards, only: :index
      before_action :initialize_opening_card_if_needed, only: :show

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
      def edit
        respond_modal_with @board
      end

      # POST /boards
      def create
        @board = Board.new(board_params)
        if @board.save
          InviteAUserInABoard.call(user: current_user, board: @board)
          fetches_all_boards
        else
          build_flash_message(:error)
        end
        render :new
      end

      # PATCH/PUT /boards/1
      def update
        build_flash_message(@board.update(board_params) ? :success : :error)
        render :update
      end

      # DELETE /boards/1
      def destroy
        @board.destroy
        build_flash_message(:success)
        redirect_to boards_url
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_board
        @board = kanban_source.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, board: :not_found)
        redirect_to action: :index
      end

      # Only allow a trusted parameter "white list" through.
      def board_params
        params.require(:board).permit(:title, :description)
      end

      def fetches_all_boards
        @boards = kanban_source.all
      end

      #
      # In the case the user uses a card direct link, the application has
      # redirected him to this BoardsController and we will open the card.
      # This method sets the @open_card variable (which will trigger the click
      # on the card), and removes the `:open_card` from the user's session.
      #
      def initialize_opening_card_if_needed
        return if request.format.html?
        return unless session[:open_card]

        create_and_assing_open_card
      end

      def i18n_resource_name
        t('sento.kanban.board')
      end
    end
  end
end
