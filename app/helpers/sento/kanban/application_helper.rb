module Sento
  module Kanban
    module ApplicationHelper
      # http://nithinbekal.com/posts/rails-presenters/
      def present(model)
        klass = "Sento::Kanban::#{model.class}Presenter".constantize
        presenter = klass.new(model, self)
        yield(presenter) if block_given?
      end
    end
  end
end
