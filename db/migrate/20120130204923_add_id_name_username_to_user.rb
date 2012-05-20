class AddIdNameUsernameToUser < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :name, :string
   	add_column :users, :fb_id, :string
  	add_column :users, :username, :string

  	add_index :users, :first_name
  	add_index :users, :last_name
  	add_index :users, :name
  	add_index :users, :fb_id
  end
end
