module Sento
  module Kanban
    class CreateNewCommentCreatedActivity
      include Interactor
      include ActivityCreator
      include Sento::Kanban::InteractorTimer

      def call
        key = 'sento.kanban.new_comment_created'
        values = { card_title: context.card.title,
                   card_id: context.card.id,
                   card_link: true,
                   comment: context.comment.body }

        create_activity_from(context, key, values)
      end
    end
  end
end
