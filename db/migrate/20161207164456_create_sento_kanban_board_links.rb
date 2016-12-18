class CreateSentoKanbanBoardLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :sento_kanban_board_links do |t|
      t.integer :board_id, null: false
      t.integer :board_linkable_id, null: false
      t.string :board_linkable_type, null: false

      t.timestamps null: false
    end

    add_index :sento_kanban_board_links,
              [:board_linkable_id, :board_linkable_type],
              name: 'index_sento_kanban_board_links_on_board_linkable'
    add_index :sento_kanban_board_links,
              [:board_id, :board_linkable_id, :board_linkable_type],
              unique: true,
              name: 'index_sento_kanban_board_links_on_boards_and_board_linkable'
  end
end
