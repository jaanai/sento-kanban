class CreateSentoKanbanBoardLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :sento_kanban_board_links do |t|
      t.integer :board_id, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :sento_kanban_board_links, [:board_id, :user_id], unique: true
  end
end
