class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    if ActiveRecord::Base.connection.table_exists?('users')
      unless column_exists? :users, :username
        add_column :users, :username, :string, index: true
      end
      unless column_exists? :users, :fullname
        add_column :users, :fullname, :string
      end
      unless column_exists? :users, :avatar
        add_column :users, :avatar, :string
      end
    else
      create_table :users do |t|
        t.string :username, index: true
        t.string :fullname
        t.string :avatar
      end
    end
  end
end
