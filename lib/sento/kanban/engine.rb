module Sento
  module Kanban
    class Engine < ::Rails::Engine
      isolate_namespace Sento::Kanban
    end
  end
end
