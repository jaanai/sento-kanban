module Sento
  module Kanban
    class Comment < ApplicationRecord
      # ~~~ Callbacks ~~~
      before_validation :update_board_from_card, on: :create

      # ~~~ Associations ~~~
      belongs_to :board
      belongs_to :card
      belongs_to :author, class_name: '::User'
      has_one :activity, dependent: :destroy

      # ~~~ Validations ~~~
      validates :board_id, :card_id, :author_id, :body, presence: true

      # ~~~ scopes ~~~

      # ~~~ Special behaviors ~~~
      searchkick text_middle: [:body], autocomplete: [:body]

      # ~~~ Custom instance methods ~~~

      private

      def update_board_from_card
        self.board = card.board
      end
    end
  end
end
