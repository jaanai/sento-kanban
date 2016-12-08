class CreateSentoKanbanComments < ActiveRecord::Migration[5.0]
  def change
    create_table :sento_kanban_comments do |t|
      t.integer :board_id, null: false, index: true
      t.integer :card_id, null: false, index: true
      t.integer :author_id, null: false
      t.text :body

      t.timestamps null: false
    end
  end
end
