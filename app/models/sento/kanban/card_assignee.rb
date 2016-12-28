module Sento
  module Kanban
    class CardAssignee < ApplicationRecord
      # ~~~ Associations ~~~
      belongs_to :card
      belongs_to :user, class_name: '::User'

      # ~~~ Validations ~~~
      validates :card_id, :user_id, presence: true
      validates :card_id, uniqueness: { scope: :user_id }

      # ~~~ Custom class methodes ~~~
    end
  end
end
