module Sento
  module Kanban
    class CommentPresenter < CardPresenter
      def title
        object.card.title
      end

      def column_name
        object.card.column.name
      end

      private

      def object
        return @model if @model.is_a?(Sento::Kanban::Comment)

        if @model.is_a?(Hashie::Mash)
          return Sento::Kanban::Comment.find(@model._id)
        end
      end
    end
  end
end
