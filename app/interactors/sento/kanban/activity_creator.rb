module Sento
  module Kanban
    module ActivityCreator
      extend ActiveSupport::Concern

      def create_activity_from(context, key, values)
        board = context.board || context.card.board
        column = context.column
        card = context.card
        author = context.author

        Activity.create!(board: board, column: column, card: card,
                         author: author, i18n_key: key, i18n_values: values)
      end
    end
  end
end
