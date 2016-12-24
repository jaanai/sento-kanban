require_dependency 'sento/kanban/concerns/interactor_timer'

module Sento
  module Kanban
    class NotifyCardWatcher
      include Interactor
      include Sento::Kanban::InteractorTimer

      def call
        return if context.card.watchers.empty?

        context.card.watchers.each do |watcher|
          CardMailer.notify_watcher(watcher, context.card).deliver_now
        end
      end
    end
  end
end
