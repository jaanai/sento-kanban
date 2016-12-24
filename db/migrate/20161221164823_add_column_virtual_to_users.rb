class AddColumnVirtualToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :virtual, :boolean, default: false, null: false
    add_index :users, :virtual
  end
end
