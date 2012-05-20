class AddVoteCountsToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :vote_count, :integer

    add_column :answers, :score, :integer

  end
end
