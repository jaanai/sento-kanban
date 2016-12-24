module Sento
  module Kanban
    class Board < ApplicationRecord
      # ~~~ Associations ~~~
      has_many :columns, dependent: :destroy
      has_many :cards, through: :columns
      has_many :board_links, dependent: :destroy
      has_many :all_members,
               through: :board_links,
               class_name: '::User',
               source: :user
      has_many :members,
               -> { where(users: { virtual: false }) },
               through: :board_links,
               class_name: '::User',
               source: :user
      has_many :virtual_members,
               -> { where(users: { virtual: true }) },
               through: :board_links,
               class_name: '::User',
               source: :user
      has_many :activities, dependent: :destroy

      # ~~~ Validations ~~~
      validates :title, presence: true

      # ~~~ Custom class methodes ~~~
    end
  end
end
