module Sento
  module Kanban
    class AddUserToABoard
      include Interactor

      def call
        Rails.logger.debug "[debug(#{__FILE__.split("app/")[1]}:#{__LINE__})] AddUserToABoard.call ..."
        board = context.board
        user = context.user

        Rails.logger.debug "[debug(#{__FILE__.split("app/")[1]}:#{__LINE__})] board: #{board.inspect}"
        Rails.logger.debug "[debug(#{__FILE__.split("app/")[1]}:#{__LINE__})] user: #{user.inspect}"
        context.fail! unless board && user

        Rails.logger.debug "[debug(#{__FILE__.split("app/")[1]}:#{__LINE__})] Adding user to the board ..."
        board.users << user
      end
    end
  end
end
