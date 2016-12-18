require_dependency 'sento/kanban/concerns/avatar_presenter'

module Sento
  module Kanban
    class SearchPresenter < BasePresenter
      include Sento::Kanban::AvatarPresenter

      def as_json(options = {})
        json = super(options)

        presented_object = presenter_name.new(@model, h)
        presented_object.json_keys.each do |key|
          json[key] = presented_object.send(key)
        end

        json
      end

      private

      def model_type_to_class_name
        @model._type.classify.demodulize
      end

      def presenter_name
        "Sento::Kanban::#{model_type_to_class_name}Presenter".constantize
      end
    end
  end
end
