class AddCurrentBoardIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :current_board_id, :integer
  end
end
