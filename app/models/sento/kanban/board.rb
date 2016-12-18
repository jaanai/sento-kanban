module Sento
  module Kanban
    class Board < ApplicationRecord
      # ~~~ Associations ~~~
      has_many :columns, dependent: :destroy
      has_many :cards, through: :columns
      has_many :users,
               through: :board_links,
               class_name: '::User',
               source: :board_linkable,
               source_type: 'User'
      has_many :invitations,
               through: :board_links,
               class_name: 'Sento::Kanban::Invitation',
               source: :board_linkable,
               source_type: 'Sento::Kanban::Invitation'
      has_many :board_links, dependent: :destroy
      has_many :activities, dependent: :destroy

      # ~~~ Validations ~~~
      validates :title, presence: true

      # ~~~ Custom class methodes ~~~
    end
  end
end
