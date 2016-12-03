module Sento
  module Kanban
    class Card < ApplicationRecord
      # ~~~ Callbacks ~~~
      before_validation :update_board_from_column, on: :create
      before_validation :update_position, on: :create

      # ~~~ Associations ~~~
      belongs_to :board
      belongs_to :column

      # ~~~ Validations ~~~
      validates :board_id, :column_id, :title, :position, presence: true

      private

      def update_board_from_column
        self.board = column.board
      end

      def update_position
        self.position = 0
      end
    end
  end
end
