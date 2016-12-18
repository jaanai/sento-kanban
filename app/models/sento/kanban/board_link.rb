module Sento
  module Kanban
    class BoardLink < ApplicationRecord
      # ~~~ Associations ~~~
      belongs_to :board
      belongs_to :board_linkable, polymorphic: true

      # ~~~ Validations ~~~
      validates :board_id, :board_linkable_id, :board_linkable_type,
                presence: true
      validates :board_id, uniqueness: { scope: [:board_linkable_id,
                                                 :board_linkable_type] }
    end
  end
end
