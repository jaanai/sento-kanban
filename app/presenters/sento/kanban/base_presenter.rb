# http://nithinbekal.com/posts/rails-presenters/

module Sento
  module Kanban
    class BasePresenter < SimpleDelegator
      def initialize(model, view)
        @model = model
        @view = view
        super(model)
      end

      def h
        @view
      end
    end
  end
end
