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
      has_many :card_watchers
      has_many :watchers,
               through: :card_watchers,
               class_name: '::User',
               source: :user
      has_many :card_assignees
      has_many :assignees,
               through: :card_assignees,
               class_name: '::User',
               source: :user

      # ~~~ Validations ~~~
      validates :board_id, :column_id, :title, presence: true

      # ~~~ scopes ~~~
      scope :without_archived, -> { where(archived: false) }

      # ~~~ Special behaviors ~~~
      ranks :card_order
      searchkick text_middle: [:title, :description],
                 autocomplete: [:title, :description]

      # ~~~ Custom class methods ~~~
      #
      # Default ElasticSearch query used by a column to show the cards, and by
      # the filters in order to reset the filtering.
      #
      # @see Sento::Kanban::ColumnPresenter
      #
      def self.default_elasticsearch_query
        {
          where: { archived: false },
          order: { card_order: :desc }
        }
      end

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
      # Extends the Searchkick#search_data method in order to index some model
      # associations.
      #
      def search_data
        attributes = respond_to?(:to_hash) ? to_hash : serializable_hash
        attributes.merge(assignee_ids: assignee_ids)
      end

      private

      def update_board_from_column
        self.board = column.board
      end
    end
  end
end
