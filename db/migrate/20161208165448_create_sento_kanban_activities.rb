class CreateSentoKanbanActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :sento_kanban_activities do |t|
      t.integer :board_id, null: false, index: true
      t.integer :column_id
      t.integer :card_id
      t.integer :author_id, null: false, index: true

      t.string :i18n_key, null: false
      t.text :i18n_values

      t.timestamps null: false
    end
  end
end
