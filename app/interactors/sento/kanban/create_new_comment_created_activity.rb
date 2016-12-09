module Sento
  module Kanban
    class CreateNewCommentCreatedActivity
      include Interactor
      include ActivityCreator

      def call
        key = 'sento.kanban.new_comment_created'
        values = { card_title: context.card.title,
                   card_id: context.card.id,
                   comment: context.comment.body }

        create_activity_from(context, key, values)
      end
    end
  end
end
