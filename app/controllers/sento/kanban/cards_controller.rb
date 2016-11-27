module Sento
  module Kanban
    class CardsController < ApplicationController
      respond_to :html, :json

      def index
      end

      def show
        @card = Card.first
        respond_modal_with @card
      end
    end
  end
end
