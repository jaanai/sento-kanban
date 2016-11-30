module Sento
  module Kanban
    class Engine < ::Rails::Engine
      isolate_namespace Sento::Kanban

      config.before_initialize do
        config.i18n.load_path += Dir["#{config.root}/config/locales/**/*.yml"]
      end
    end
  end
end
