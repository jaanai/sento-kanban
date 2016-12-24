class CreateSentoKanbanCardsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :sento_kanban_cards_users do |t|
      t.integer :card_id, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :sento_kanban_cards_users, [:card_id, :user_id], unique: true
  end
end
