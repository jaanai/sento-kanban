module Sento
  module Kanban
    module User
      extend ActiveSupport::Concern

      # ~~~~ Virtual attributes ~~~~
      # Class attribute used to transmit the ElasticSearch downtime to the
      # controllers
      cattr_accessor :elasticsearch_down

      included do
        # ~~~~ Associations ~~~~
        belongs_to :current_board,
                   optional: true,
                   class_name: 'Sento::Kanban::Board'
        has_many :board_links, class_name: 'Sento::Kanban::BoardLink'
        has_many :boards,
                 through: :board_links,
                 class_name: 'Sento::Kanban::Board'
        has_many :cards, through: :boards, class_name: 'Sento::Kanban::Card'

        # ~~~~ Validations ~~~~
        validates :username, uniqueness: true

        # ~~~~ Special behaviors ~~~~
        searchkick word_start: [:username], autocomplete: [:username]

        #
        # Password not required for invited users
        #
        def password_required?
          super if virtual == false
        end
      end

      #
      # Updates the User attributes handling the case where ElasticSearch is
      # down and searchkick tries to update its index
      #
      # @param attributes [Hash] new user attributes
      # @return [TrueClass, FalseClass] true when the user has been updated,
      #   otherwise false
      #
      def update(attributes)
        result = super(attributes)
        self.elasticsearch_down = false

        result
      rescue Faraday::ConnectionFailed => exception
        Rails.logger.error 'ElasticSearch connection error: ' \
                           "#{exception.message}"
        self.elasticsearch_down = true
      end

      def search_data
        { username: username }
      end

      #
      # Override of the searchkick should_index? method which determine if the
      # model instance should be re-indexed or not.
      # We use it in order to re-index only when the indexed data has changed.
      # This allows the user to use the application even when ElasticSearch is
      # down.
      #
      def reindex
        return unless search_data.keys.detect { |key| send("#{key}_changed?") }
        Rails.logger.debug "User #{id} is gonna be re-indexed"
        super
      end

      module ClassMethods
      end
    end
  end
end
