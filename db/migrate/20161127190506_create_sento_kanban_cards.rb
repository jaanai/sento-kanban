class CreateSentoKanbanCards < ActiveRecord::Migration[5.0]
  def change
    create_table :sento_kanban_cards do |t|
      t.integer :board_id, null: false, index: true
      t.integer :column_id, null: false, index: true
      t.string :title, null: false
      t.text :description
      t.integer :position, null: false

      t.timestamps
    end
  end
end
