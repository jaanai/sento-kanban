module Sento
  module Kanban
    module User
      extend ActiveSupport::Concern

      included do
        # ~~~~ Associations ~~~~
        has_many :boards, through: :board_links,
                          class_name: 'Sento::Kanban::Board'
        has_many :board_links, class_name: 'Sento::Kanban::BoardLink'
        has_many :cards, through: :boards, class_name: 'Sento::Kanban::Card'

        # ~~~~ Validations ~~~~
        validates :username, presence: true, uniqueness: true
      end

      module ClassMethods
      end
    end
  end
end
