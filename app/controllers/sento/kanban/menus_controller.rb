module Sento
  module Kanban
    #
    # This controller is used in order to load the right floating menu
    #
    class MenusController < ApplicationController
      # GET /menu
      def show
        @board = current_user.current_board

        render layout: false
      end
    end
  end
end
