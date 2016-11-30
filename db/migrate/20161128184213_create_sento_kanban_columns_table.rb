class CreateSentoKanbanColumnsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :sento_kanban_columns do |t|
      t.integer :board_id, null: false, index: true
      t.string :name, null: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
