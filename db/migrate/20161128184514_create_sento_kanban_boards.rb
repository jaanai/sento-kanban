class CreateSentoKanbanBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :sento_kanban_boards do |t|
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
