module Sento
  module Kanban
    class Column < ApplicationRecord
      # ~~~ Associations ~~~
      belongs_to :board
      has_many :cards, dependent: :destroy

      # ~~~ Validations ~~~
      validates :name, :board_id, presence: true
    end
  end
end
