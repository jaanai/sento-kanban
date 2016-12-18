module Sento
  module Kanban
    module ServiceDowntimeHandlingForElasticSearch
      extend ActiveSupport::Concern

      def render(*args)
        detect_elasticsearch_failure
        super
      end

      #
      # On create/update and destroy, ElasticSearch indexes are updated.
      # The model has a class attribute which will stores on error if
      # ElasticSearch is down or not and let continue the code which hides this
      # to the user.
      # Here we are then collecting this information in order to disable the
      # features using ElasticSearch.
      # As soon as ElasticSearch is back, the features are usable again.
      #
      def detect_elasticsearch_failure
        @elasticsearch_down ||= User.elasticsearch_down
      end
    end
  end
end
