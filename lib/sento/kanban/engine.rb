module Sento
  module Kanban
    class Engine < ::Rails::Engine
      isolate_namespace Sento::Kanban

      config.autoload_paths << File.expand_path('../../../../app/interactors',
                                                __FILE__)
      config.autoload_paths << File.expand_path('../../../../app/presenters',
                                                __FILE__)

      config.before_initialize do
        config.i18n.load_path += Dir["#{config.root}/config/locales/**/*.yml"]
      end

      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :machinist
      end
    end
  end
end
