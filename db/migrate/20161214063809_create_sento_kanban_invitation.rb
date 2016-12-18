class CreateSentoKanbanInvitation < ActiveRecord::Migration[5.0]
  def change
    create_table :sento_kanban_invitations do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.integer :board_id, null: false
      t.integer :inviter_id, null: false

      t.timestamps null: false
    end

    add_index :sento_kanban_invitations, :email
    add_index :sento_kanban_invitations, [:email, :board_id], unique: true
  end
end
