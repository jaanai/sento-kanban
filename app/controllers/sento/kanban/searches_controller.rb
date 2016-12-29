module Sento
  module Kanban
    class SearchesController < ApplicationController
      #
      # Filter menu
      #
      def show
        @context = FilterBoardCards.call(search: params[:search])
      end

      #
      # Global search menu
      #
      def autocomplete
        @board = current_user.current_board
        context = BuildSearchAutocompleteResults.call(query: params[:query],
                                                      controller: self)
        render json: build_results_from(context)
      end

      private

      def build_results_from(context)
        results = {}
        if context.cards_result.present?
          results[:cards] = context.cards_result
          results[:cards_header_name] = I18n.t('sento.kanban.shared' \
                                               '.cards_header')
        end

        if context.members_result.present?
          results[:members] = context.members_result
          results[:members_header_name] = I18n.t('sento.kanban.shared' \
                                                 '.members_header')
        end

        results
      end
    end
  end
end
