class CreateCardWatchersAndAssigneesTables < ActiveRecord::Migration[5.0]
  def change
    create_table :sento_kanban_card_watchers do |t|
      t.integer :card_id, null: false, index: true
      t.integer :user_id, null: false, index: true

      t.timestamps null: false
    end

    add_index :sento_kanban_card_watchers, [:card_id, :user_id], unique: true

    create_table :sento_kanban_card_assignees do |t|
      t.integer :card_id, null: false, index: true
      t.integer :user_id, null: false, index: true

      t.timestamps null: false
    end

    add_index :sento_kanban_card_assignees, [:card_id, :user_id], unique: true
  end
end
