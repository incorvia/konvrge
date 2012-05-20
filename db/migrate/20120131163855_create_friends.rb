class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string  :name
      t.integer :fb_id
      t.integer :user_id

      t.timestamps
    end

    add_index :friends, :name
    add_index :friends, :fb_id
    add_index :friends, :user_id
  end
end
