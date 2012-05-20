class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :user_id
      t.string :user_name

      t.timestamps
    end

    add_index :questions, :user_id
  end
end
