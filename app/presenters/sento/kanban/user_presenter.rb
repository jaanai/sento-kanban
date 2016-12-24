require_dependency 'sento/kanban/concerns/avatar_presenter'
require_dependency 'sento/kanban/concerns/member_presenter'

module Sento
  module Kanban
    class UserPresenter < BasePresenter
      include Sento::Kanban::AvatarPresenter
      include Sento::Kanban::MemberPresenter

      def avatar_url_or_fallback
        model_avatar_or_fallback(@model)
      end

      def json_keys
        [:fullname_or_username, :avatar_url_or_fallback,
         :add_member_to_board_button, :profile_path, :current_user]
      end

      #
      # Generates the URL in order to add the @model to the current_user's board
      #
      def add_member_to_board_button
        return nil unless can_model_be_added_to_the_board?

        if @model._type == 'sento/kanban/invitation'
          view.link_to 'Add', h.board_invitation_add_path(board, @model.id), method: :post, class: 'btn btn-outline-primary float-xs-right', remote: true
        elsif @model._type == 'user'
          view.link_to 'Add', h.board_user_add_path(board, @model.id), method: :post, class: 'btn btn-outline-primary float-xs-right', remote: true
        end
      end

      #
      # Generates the URL to the search item page
      #
      def profile_path
        if @model._type == 'sento/kanban/invitation'
          view.invitation_path(@model.id)
        elsif @model._type == 'user'
          view.user_path(@model.id)
        end
      end

      #
      # Determines if the current search result matches the current user.
      # It is uses in order to show the "You" label in the action acrea
      #
      def current_user
        @model == h.current_user
      end

      def card_member_path(card)
        if card.watchers.include?(@model)
          h.card_member_path(card, @model)
        else
          h.card_members_path(card)
        end
      end

      def card_member_verb(card)
        card.watchers.include?(@model) ?  :delete : :post
      end

      private

      def board
        h.instance_variable_get('@board')
      end

      def can_model_be_added_to_the_board?
        return false unless board
        return false if @model._type == 'sento/kanban/card'

        if @model._type == 'sento/kanban/invitation'
          board.invitations
        elsif @model._type == 'user'
          board.users
        end.exists?(@model.id) == false
      end

      def view
        h.view_context
      end
    end
  end
end
