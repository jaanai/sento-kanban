module Sento
  module Kanban
    class Card < ApplicationRecord
      include RankedModel

      # ~~~ Virtual attributes ~~~

      # ~~~ Callbacks ~~~
      before_validation :update_board_from_column, on: :create

      # ~~~ Associations ~~~
      belongs_to :board
      belongs_to :column
      has_many :comments, dependent: :destroy
      has_many :activities
      has_many :card_links
      has_and_belongs_to_many :watchers, class_name: '::User'

      # ~~~ Validations ~~~
      validates :board_id, :column_id, :title, presence: true

      # ~~~ scopes ~~~
      scope :without_archived, -> { where(archived: false) }

      # ~~~ Special behaviors ~~~
      ranks :card_order
      searchkick text_middle: [:title, :description],
                 autocomplete: [:title, :description]

      # ~~~ Custom instance methods ~~~
      #
      # Updates the card's archived to true.
      #
      # @return [TrueClass,FalseClass] true when update worked, otherwise false.
      #
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
