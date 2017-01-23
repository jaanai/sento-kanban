require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class AddANewCommentToACard
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        card = context.card

        context.comment = card.comments.new(context.params)
        context.comment.author = context.author

        context.fail! unless context.comment.save
      end
    end
  end
end
