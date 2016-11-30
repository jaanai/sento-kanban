module Sento
  module Kanban
    class Column < ApplicationRecord
      # ~~~ Associations ~~~
      belongs_to :board
      has_many :cards

      # ~~~ Validations ~~~
      validates :name, :board_id, presence: true
    end
  end
end
