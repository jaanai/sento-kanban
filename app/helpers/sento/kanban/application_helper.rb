module Sento
  module Kanban
    module ApplicationHelper
      # http://nithinbekal.com/posts/rails-presenters/
      def present(model)
        model_class_name = model.class.name.demodulize
        klass = "Sento::Kanban::#{model_class_name}Presenter".constantize
        presenter = klass.new(model, self)
        yield(presenter) if block_given?
      rescue NameError => error
        Rails.logger.error 'ERROR: The presenter Sento::Kanban::' \
                           "#{model.class}Presenter doesn't exists. " \
                           "(#{error.inspect})"
        raise
      end
    end
  end
end
