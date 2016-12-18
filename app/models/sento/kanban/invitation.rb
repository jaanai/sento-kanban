module Sento
  module Kanban
    class Invitation < ApplicationRecord
      # ~~~ Virtual attributes ~~~
      attr_accessor :last_sign_in_at, :current_sign_in_at, :fullname

      # ~~~ Callbacks ~~~

      # ~~~ Associations ~~~
      belongs_to :board
      belongs_to :inviter, class_name: '::User'
      has_many :boards,
               through: :board_links,
               class_name: 'Sento::Kanban::Board'
      has_many :board_links,
               class_name: 'Sento::Kanban::BoardLink',
               as: :board_linkable

      # ~~~ Validations ~~~
      validates :email, :username, :board_id, :inviter_id, presence: true
      validates :email, uniqueness: { scope: :board_id }

      # ~~~ scopes ~~~

      # ~~~ Special behaviors ~~~
      searchkick word_start: [:username], autocomplete: [:username]

      # ~~~ Custom instance methods ~~~
    end
  end
end
