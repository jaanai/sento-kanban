require_dependency 'sento/kanban/application_controller'

module Sento
  module Kanban
    class WatchersController < ApplicationController
      before_action :fetches_current_card
      before_action :fetches_watcher, only: [:create, :edit, :destroy]
      before_action :fetches_all_members

      # GET /cards/1/watchers
      def index
        render layout: false
      end

      # POST /cards/1/watchers
      def create
        AddNewCardMember.call(card: @card, user: @member, author: current_user)
      end

      # GET /cards/1/watchers/1/edit
      def edit
        render layout: false
      end

      # DELETE /cards/1/watcher/1
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
        redirect_to board_url(root_path)
      end

      def fetches_watcher
        id = params.key?(:watcher) ? params[:watcher][:member_id] : params[:id]
        @member = @card.board.all_members.find(id)
      rescue ActiveRecord::RecordNotFound
        build_flash_message(:error, card: :not_found)
        redirect_to board_url(@card.board)
      end

      def fetches_all_members
        @members = @card.board.all_members.order(:username)
      end

      def i18n_resource_name
        t('sento.kanban.watcher')
      end
    end
  end
end
