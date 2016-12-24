require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class MembersController < ApplicationController
      before_action :fetches_current_card
      before_action :fetches_member, only: [:create, :edit, :destroy]
      before_action :fetches_all_members

      # GET /cards/1/members
      def index
        render layout: false
      end

      # POST /cards/1/members
      def create
        AddNewCardMember.call(card: @card, user: @member, author: current_user)
      end

      # GET /cards/1/members/1/edit
      def edit
        render layout: false
      end

      # DELETE /cards/1/member/1
      def destroy
        RemoveCardMember.call(card: @card, user: @member, author: current_user)
        render :create
      end

      private

      def fetches_current_card
        # TODO : Handle the case where not using Devise
        @card = current_user.cards.includes(:watchers).find(params[:card_id])
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, card: :not_found)
        redirect_to board_url(@board)
      end

      def fetches_member
        id = params.key?(:member) ? params[:member][:member_id] : params[:id]
        @member = @card.board.all_members.find(id)
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, card: :not_found)
        redirect_to board_url(@board)
      end

      def fetches_all_members
        @members = @card.board.all_members
      end
    end
  end
end
