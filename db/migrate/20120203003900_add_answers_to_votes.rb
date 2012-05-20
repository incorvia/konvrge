class AddAnswersToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :answer_id, :integer

    add_index :votes, :answer_id
  end
end
