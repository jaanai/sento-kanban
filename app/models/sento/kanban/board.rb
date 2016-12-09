module Sento
  module Kanban
    class Board < ApplicationRecord
      # ~~~ Associations ~~~
      has_many :columns, dependent: :destroy
      has_many :cards, through: :columns
      has_many :users, through: :board_links, class_name: '::User'
      has_many :board_links, dependent: :destroy
      has_many :activities, dependent: :destroy

      # ~~~ Validations ~~~
      validates :title, presence: true
    end
  end
end
