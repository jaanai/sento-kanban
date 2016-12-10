module Sento
  module Kanban
    class Card < ApplicationRecord
      include RankedModel

      # ~~~ Virtual attributes ~~~
      attr_accessor :previous_column_id, :previous_title

      # ~~~ Callbacks ~~~
      before_validation :update_board_from_column, on: :create
      before_update :remember_previous_card_information

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
      # Determines if the card has just been moved.
      #
      # @return [TrueClass,FalseClass] true when the card has been moved,
      #   otherwise false.
      #
      def moved?
        column_id != previous_column_id
      end

      #
      # Determines if the card has just been renamed.
      #
      # @return [TrueClass,FalseClass] true when the card has been renamed,
      #   otherwise false.
      #
      def renamed?
        title != previous_title
      end

      private

      def update_board_from_column
        self.board = column.board
      end

      #
      # Saves some card's information before updating the database.
      # @see #moved?
      # @see #renamed?
      #
      def remember_previous_card_information
        self.previous_column_id = column_id_was
        self.previous_title = title_was
      end
    end
  end
end
