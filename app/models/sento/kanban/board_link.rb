module Sento
  module Kanban
    class BoardLink < ApplicationRecord
      # ~~~ Associations ~~~
      belongs_to :board
      belongs_to :user

      # ~~~ Validations ~~~
      validates :board_id, :user_id, presence: true
      validates :user_id, uniqueness: { scope: :board_id }
    end
  end
end
