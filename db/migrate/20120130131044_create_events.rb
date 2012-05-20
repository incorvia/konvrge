class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :location
      t.string :category
      t.integer :user_id

      t.timestamps
    end

    add_index :events, :title
    add_index :events, :category
    add_index :events, :user_id
  end
end
