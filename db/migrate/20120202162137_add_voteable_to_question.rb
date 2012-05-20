class AddVoteableToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :score, :integer

    add_column :questions, :vote_count, :integer

  end
end
