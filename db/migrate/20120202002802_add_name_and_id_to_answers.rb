class AddNameAndIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :user_name, :string
    add_column :answers, :user_id, :string

    add_index :answers, :user_id
  end
end
