module Sento
  module Kanban
    class Board < ApplicationRecord
      # ~~~ Associations ~~~
      has_many :columns, dependent: :destroy

      # ~~~ Validations ~~~
      validates :title, presence: true
    end
  end
end
