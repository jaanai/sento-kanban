module Sento
  module Kanban
    class Activity < ApplicationRecord
      # ~~~ Callbacks ~~~

      # ~~~ Associations ~~~
      belongs_to :board
      belongs_to :column, optional: true
      belongs_to :card, optional: true
      belongs_to :comment, optional: true
      belongs_to :author, class_name: '::User'

      # ~~~ Validations ~~~
      validates :board_id, :author_id, presence: true

      # ~~~ scopes ~~~

      # ~~~ Special behaviors ~~~
      store :i18n_values, coder: JSON

      # ~~~ Custom instance methods ~~~
      def can_be_deleted?
        comment.present?
      end
    end
  end
end
