module Sento
  module Kanban
    class Board < ApplicationRecord
      # ~~~ Associations ~~~
      has_many :columns, dependent: :destroy
      has_many :users, through: :board_links
      has_many :board_links

      # ~~~ Validations ~~~
      validates :title, presence: true
    end
  end
end
