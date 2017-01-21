# This file configures Searchkick's elasticsearch instance in order to use the
# Docker Elasticsearch container.

ENV['ELASTICSEARCH_URL'] ||= 'http://elasticsearch:9200'
