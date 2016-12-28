require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class AssigneesController < ApplicationController
      before_action :fetches_current_card
      before_action :fetches_assignee, only: [:create, :edit, :destroy]
      before_action :fetches_all_members

      # GET /cards/1/assignees
      def index
        render layout: false
      end

      # POST /cards/1/assignees
      def create
        AssignCard.call(card: @card, user: @member, author: current_user)
      end

      # GET /cards/1/assignees/1/edit
      def edit
        render layout: false
      end

      # DELETE /cards/1/assignee/1
      def destroy
        UnassignCard.call(card: @card, user: @member, author: current_user)
        render :create
      end

      private

      def fetches_current_card
        # TODO : Handle the case where not using Devise
        @card = current_user.cards.includes(:assignees).find(params[:card_id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, card: :not_found)
        redirect_to board_url(root_path)
      end

      def fetches_assignee
        id = params[:id]
        id = params[:assignee][:member_id] if params.key?(:assignee)
        @member = @card.board.all_members.find(id)
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, card: :not_found)
        redirect_to board_url(@card.board)
      end

      def fetches_all_members
        @members = @card.board.all_members.order(:username)
      end

      def i18n_resource_name
        t('sento.kanban.assignee')
      end
    end
  end
end
