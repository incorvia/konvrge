class AddVoteCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :vote_count, :integer

  end
end
