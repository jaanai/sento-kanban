module Sento
  module Kanban
    class Card < ApplicationRecord
      include RankedModel

      # ~~~ Callbacks ~~~
      before_validation :update_board_from_column, on: :create

      # ~~~ Associations ~~~
      belongs_to :board
      belongs_to :column
      has_many :comments, dependent: :destroy
      has_many :activities

      # ~~~ Validations ~~~
      validates :board_id, :column_id, :title, presence: true

      # ~~~ scopes ~~~
      scope :without_archived, -> { where(archived: false) }

      # ~~~ Special behaviors ~~~
      ranks :card_order

      # ~~~ Custom instance methods ~~~
      def archive
        update(archived: true)
      end

      private

      def update_board_from_column
        self.board = column.board
      end
    end
  end
end
