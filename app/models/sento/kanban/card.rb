module Sento
  module Kanban
    class Card < ApplicationRecord
      include RankedModel

      # ~~~ Virtual attributes ~~~
      attr_accessor :previous_column_id

      # ~~~ Callbacks ~~~
      before_validation :update_board_from_column, on: :create
      before_update :remember_the_current_column

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
      #
      # Updates the card's archived to true.
      #
      # @return [TrueClass,FalseClass] true when update worked, otherwise false.
      #
      def archive
        update(archived: true)
      end

      #
      # Determines if the cards has just been moved.
      #
      # @return [TrueClass,FalseClass] true when the card has been moved,
      #   otherwise false.
      #
      def moved?
        column_id != previous_column_id
      end

      private

      def update_board_from_column
        self.board = column.board
      end

      #
      # Saves the column ID before updating the database.
      # @see #moved?
      #
      def remember_the_current_column
        self.previous_column_id = column_id_was
      end
    end
  end
end
