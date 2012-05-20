class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :fb_id

      t.timestamps
    end

    add_index :votes, :user_id
    add_index :votes, :event_id
    add_index :votes, :fb_id
  end
end
