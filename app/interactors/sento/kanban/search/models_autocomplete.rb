require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    module Search
      class ModelsAutocomplete
        include Interactor
        include Sento::Kanban::InteractorTimer

        def call
          context.limit ||= 10

          context.cards_result = decorated_results_from(search_for_cards)
          context.members_result = decorated_results_from(search_for_members)
        end

        private

        def decorated_results_from(results)
          already_processed_result = []

          results.map do |result|
            next if already_processed_result.include?(result._id)
            already_processed_result << result._id

            Sento::Kanban::SearchPresenter.new(result, controller)
          end.compact
        end

        def controller
          context.controller
        end

        def search_for_cards
          Searchkick.search(context.query, load: false, match: :text_middle,
                            index_name: search_cards_index_name,
                            fields: [:title, :description, :body],
                            limit: context.limit, misspellings: { below: 5 })
        rescue Faraday::ConnectionFailed => exception
          Rails.logger.error 'ElasticSearch connection error: ' \
                             "#{exception.message}"
          []
        end

        def search_for_members
          ::User.search(context.query, match: :word_start, load: false,
                        fields: [:username], limit: context.limit,
                        misspellings: { below: 5 })
        rescue Faraday::ConnectionFailed => exception
          Rails.logger.error 'ElasticSearch connection error: ' \
                             "#{exception.message}"
          []
        end

        def search_cards_index_name
          [Sento::Kanban::Card, Sento::Kanban::Comment]
        end
      end
    end
  end
end
