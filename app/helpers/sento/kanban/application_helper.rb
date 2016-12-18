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
                           "#{model_class_name}Presenter doesn't exists. " \
                           "(#{error.inspect})"
        raise
      end

      def email_to_username(email)
        local_part = email.split('@').first
        local_part = local_part.gsub(/(\.|_\-)/, ' ')
        local_part.titleize
      end

      def emojify(content)
        h(content).to_str.gsub(/:([\w+-]+):/) do |match|
          emoji = Emoji.find_by_alias($1)
          if emoji
            %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" class="emoji" />)
          else
            match
          end
        end.html_safe if content.present?
      end
    end
  end
end
